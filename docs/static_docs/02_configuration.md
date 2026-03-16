# 02. Static Site Configuration

The configuration for the `static` service is minimal and entirely self-contained within its Docker image. Unlike other services, it does not depend on any environment variables from the `.env` file.

The setup is handled by its `Dockerfile`, which performs two main configuration steps:

1.  It copies the `index.html` file into the web root directory (`/var/www/html/`).
2.  It starts a tiny HTTP server provided by BusyBox.

### The HTTP Server

This service uses `busybox httpd`, which is intentionally minimal and perfect for static content:

```sh
httpd -f -p 80 -h /var/www/html
```

Let's break down each part:

- **`-f`**: Run in the foreground (required for Docker PID 1).
- **`-p 80`**: Listen on port 80 inside the container.
- **`-h /var/www/html`**: Serve files from the static web root.
