# 05. WordPress Persistence

Containers are designed to be ephemeral, meaning they can be stopped, destroyed, and recreated at any time. However, an application like WordPress is **stateful**; it has data (posts, pages, user uploads, themes, plugins) that must be preserved. This is where data persistence becomes critical.

In this project, all WordPress data is persisted using a **Docker named volume** stored under `/home/<login>/data` on the host.

### The WordPress Volume Definition

The `docker-compose.yml` file defines how data is persisted for the `wordpress` service:

```yaml
services:
  wordpress:
    # ...
    volumes:
      - wordpress_data:/var/www/html
# ...
volumes:
  wordpress_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /home/<login>/data/wordpress
```

Let's break this down:

- **`volumes: - wordpress_data:/var/www/html`**: This line tells Docker to mount a volume named `wordpress_data` to the `/var/www/html` directory inside the container. `/var/www/html` is the document root where WordPress core files, themes, plugins, and uploads are all stored.

- **The top-level `volumes:` block**: This section defines *how* the `wordpress_data` volume works.
  - **`driver: local`**: Uses the standard local filesystem driver.
  - **`driver_opts: ...`**: These options pin the named volume to a specific host path to satisfy the project requirement.
    - **`device: /home/<login>/data/wordpress`**: This specifies the exact path on the **host machine** where the data will be stored.

### Named Volume Behavior

The `/var/www/html` directory inside the container is backed by a named volume whose storage lives under `/home/<login>/data/wordpress` on the host.

- **Pros:**
  - **Easy Access:** You can directly browse, inspect, and even edit the WordPress files on your host machine using a text editor or file manager.
  - **Intuitive Location:** The data is stored in a predictable, user-defined location.

- **Cons:**
  - **Less Portable:** The `docker-compose.yml` file depends on a specific path existing on the host machine. If you move the project, you must update the path.

### What Is Being Persisted?

By mounting a volume to `/var/www/html`, we are ensuring that the entire state of the WordPress site is preserved. This includes:

- **WordPress Core Files:** The PHP files downloaded by the `setup.sh` script.
- **`wp-config.php`**: The crucial configuration file. Its persistence is what prevents the setup script from running the installation more than once.
- **The `wp-content` Directory:** This is the most critical folder for user data.
  - `wp-content/themes/`: Your installed themes.
  - `wp-content/plugins/`: Your installed plugins.
  - `wp-content/uploads/`: All media files (images, documents, etc.) you upload through the WordPress dashboard.

In summary, the named volume stored under `/home/<login>/data` ensures that your entire WordPress site is durable, secure from container deletion, and easily accessible on your host machine.
