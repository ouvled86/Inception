#!/bin/bash

# Diagnostic script for Inception Portfolio Overhaul
# Tests all endpoints and container health

echo "=========================================="
echo "   Inception System Diagnostic Tool"
echo "=========================================="

# Load env if present
if [ -f srcs/.env ]; then
    set -a
    . srcs/.env
    set +a
fi

LOGIN_DOMAIN=${DOMAIN_NAME:-"$(whoami).42.fr"}

# 1. Check Container Status
echo -e "\n[1/4] Checking Docker Containers..."
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# 2. Check Database Connectivity (internal)
echo -e "\n[2/4] Testing MariaDB Connectivity..."
docker exec mariadb mariadb -u $MYSQL_USER -p$MYSQL_PASSWORD -e "USE portfolio_db; SHOW TABLES;" &> /dev/null
if [ $? -eq 0 ]; then
    echo "✅ MariaDB: portfolio_db is accessible and tables exist."
else
    echo "❌ MariaDB: Could not access portfolio_db. Checking logs..."
    docker logs mariadb --tail 20
fi

# 3. Check Nginx Endpoints
echo -e "\n[3/4] Testing Nginx Endpoints..."
ENDPOINTS=(
    "https://${LOGIN_DOMAIN}/ (WordPress)"
    "https://${LOGIN_DOMAIN}/static/ (Static Site)"
    "https://${LOGIN_DOMAIN}/adminer (Adminer)"
    "https://${LOGIN_DOMAIN}/taboo/ (Taboo)"
)

for ep in "${ENDPOINTS[@]}"; do
    NAME=$(echo $ep | cut -d' ' -f2-)
    URL=$(echo $ep | cut -d' ' -f1)
    
    # Using -k because of self-signed certs
    HTTP_CODE=$(curl -o /dev/null -s -w "%{http_code}" -k -H "Host: ${LOGIN_DOMAIN}" https://localhost${URL#https://${LOGIN_DOMAIN}})
    
    if [ "$HTTP_CODE" == "200" ]; then
        echo "✅ $URL ($NAME): 200 OK"
    elif [ "$HTTP_CODE" == "301" ] || [ "$HTTP_CODE" == "302" ]; then
        echo "⚠️  $URL ($NAME): $HTTP_CODE Redirect (Check Nginx config)"
    else
        echo "❌ $URL ($NAME): $HTTP_CODE Error"
    fi
done

# 4. Check Backend Logs (Static Service)
echo -e "\n[4/4] Checking Static Service Logs..."
docker logs portfolio --tail 10

echo -e "\n=========================================="
echo "   Diagnostic Complete"
echo "=========================================="
