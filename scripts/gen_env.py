#!/usr/bin/env python3
import argparse
import secrets
import string
from pathlib import Path


ALPHABET = string.ascii_letters + string.digits


def gen_secret(length=32):
    return "".join(secrets.choice(ALPHABET) for _ in range(length))


def safe_admin_user(login):
    lowered = login.lower()
    if "admin" in lowered:
        return "user42"
    return login


def build_env(login, data_path):
    domain = f"{login}.42.fr"
    admin_user = safe_admin_user(login)
    return "\n".join(
        [
            "# NGINX",
            f"DOMAIN_NAME={domain}",
            "",
            "# MariaDB",
            "MYSQL_DATABASE=wordpress",
            f"MYSQL_USER={login}",
            f"MYSQL_PASSWORD={gen_secret(32)}",
            f"MYSQL_ROOT_PASSWORD={gen_secret(32)}",
            "",
            "# WordPress",
            "WP_TITLE=Inception",
            f"WP_ADMIN_USER={admin_user}",
            f"WP_ADMIN_PASSWORD={gen_secret(32)}",
            f"WP_ADMIN_EMAIL={admin_user}@example.com",
            f"WP_USER={login}_user",
            f"WP_USER_PASSWORD={gen_secret(32)}",
            f"WP_USER_EMAIL={login}_user@example.com",
            "",
            "# FTP",
            f"FTP_USER={login}",
            f"FTP_PASS={gen_secret(32)}",
            "",
            "# Redis",
            "REDIS_HOST=redis",
            "REDIS_PORT=6379",
            f"REDIS_PASSWORD={gen_secret(32)}",
            "",
            "# Paths",
            f"DATA_PATH={data_path}",
            "",
        ]
    )


def main():
    parser = argparse.ArgumentParser(description="Generate srcs/.env with random secrets.")
    parser.add_argument("--login", required=True, help="42 login to use for domain and usernames")
    parser.add_argument("--out", required=True, help="Output .env path")
    parser.add_argument("--data-path", required=True, help="Host data path (e.g., /home/login/data)")
    args = parser.parse_args()

    out_path = Path(args.out)
    if out_path.exists():
        return 0

    env_text = build_env(args.login, args.data_path)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(env_text, encoding="utf-8")
    try:
        out_path.chmod(0o600)
    except OSError:
        pass
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
