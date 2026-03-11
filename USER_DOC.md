# User Documentation - Inception

Welcome to the **Inception** platform. This guide will help you navigate and manage your new infrastructure.

## 1. Provided Services

- **Main Website**: A WordPress blog accessible at `https://ouel-bou.42.fr`.
- **Taboo Table**: Taboo table game is accessible at `https://ouel-bou.42.fr/taboo`.
- **Admin Panel**: Manage WordPress posts at `https://ouel-bou.42.fr/wp-admin`.
- **Database GUI**: Manage MariaDB tables via Adminer at `https://ouel-bou.42.fr/adminer`.
- **Static Portfolio**: A simple showcase site at `https://ouel-bou.42.fr/static`.
- **Monitoring**: Real-time resource usage dashboard at `http://localhost:8080`.
- **FTP Access**: Upload/download files to WordPress using port `21`.

## 2. Managing the Project

- **To Start**: Run `make` in the root directory.
- **To Stop**: Run `make down` to stop the containers without removing data.
- **To Reset**: Run `make clean` to remove containers and start fresh next time.

## 3. Credentials

Your credentials are managed in the `srcs/.env` file.

- **WordPress Admin**: See `WP_ADMIN_USER` and `WP_ADMIN_PASSWORD`.
- **FTP**: See `FTP_USER` and `FTP_PASS`.
- **Database Root**: See `MYSQL_ROOT_PASSWORD`.

## 4. Health Check

To verify that everything is running correctly:

1. Run `docker ps` - all 8 containers should be `Up`.
2. Open `https://ouel-bou.42.fr` in your browser.
3. Check the Monitoring dashboard at `http://localhost:8080`.

## 5. Extra Documentation

Additional documentation for each service can be found in the `docs` directory:

### Adminer
- [01 The Role](docs/adminer_docs/01_the_role.md)
- [02 Networking](docs/adminer_docs/02_networking.md)
- [03 Usage](docs/adminer_docs/03_usage.md)

### FTP
- [01 The Role](docs/ftp_docs/01_the_role.md)
- [02 Networking](docs/ftp_docs/02_networking.md)
- [03 Configuration](docs/ftp_docs/03_configuration.md)
- [04 Users and Permissions](docs/ftp_docs/04_users_and_permissions.md)
- [05 Security](docs/ftp_docs/05_security.md)

### MariaDB
- [MariaDB Overview](docs/mariadb.md)
- [01 The Role](docs/mariadb_docs/01_the_role.md)
- [02 Networking](docs/mariadb_docs/02_networking.md)
- [03 Configuration](docs/mariadb_docs/03_configuration.md)
- [04 Scripting and SQL](docs/mariadb_docs/04_scripting_and_sql.md)
- [05 Persistence](docs/mariadb_docs/05_persistence.md)

### Monitoring
- [01 The Role](docs/monitoring_docs/01_the_role.md)
- [02 Components](docs/monitoring_docs/02_components.md)
- [03 Dashboards](docs/monitoring_docs/03_dashboards.md)

### Nginx
- [Nginx Overview](docs/nginx.md)
- [01 The Role](docs/nginx_docs/01_the_role.md)
- [02 Networking](docs/nginx_docs/02_networking.md)
- [03 Configuration](docs/nginx_docs/03_configuration.md)
- [04 SSL and Security](docs/nginx_docs/04_ssl_and_security.md)
- [05 Logging and Caching](docs/nginx_docs/05_logging_and_caching.md)

### Redis
- [01 The Role](docs/redis_docs/01_the_role.md)
- [02 Networking](docs/redis_docs/02_networking.md)
- [03 Configuration](docs/redis_docs/03_configuration.md)
- [04 CLI and Commands](docs/redis_docs/04_cli_and_commands.md)
- [05 Persistence](docs/redis_docs/05_persistence.md)

### Static Portfolio
- [01 The Role](docs/static_docs/01_the_role.md)
- [02 Configuration](docs/static_docs/02_configuration.md)
- [03 Content](docs/static_docs/03_content.md)

### Taboo Game
- [01 Docker Alpine Node.js](docs/taboo/01-docker-alpine-nodejs.md)
- [02 Node.js Express](docs/taboo/02-nodejs-express.md)
- [03 WebSockets Socket.io](docs/taboo/03-websockets-socketio.md)
- [04 Nginx Reverse Proxy](docs/taboo/04-nginx-reverse-proxy.md)
- [05 Game Architecture](docs/taboo/05-game-architecture.md)

### WordPress
- [WordPress Overview](docs/wordpress.md)
- [01 The Role](docs/wordpress_docs/01_the_role.md)
- [02 Networking](docs/wordpress_docs/02_networking.md)
- [03 Configuration](docs/wordpress_docs/03_configuration.md)
- [04 Scripting and CLI](docs/wordpress_docs/04_scripting_and_cli.md)
- [05 Persistence](docs/wordpress_docs/05_persistence.md)

### Other
- [Bonus Documentation](docs/bonus.md)
