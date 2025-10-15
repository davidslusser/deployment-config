# Deployment Config

This repository contains Docker Compose templates for various Docker based web applications and shared services hosted on a VPS (Virtual Private Server).


## Usage
Using Docker Compose is similar for all service templates in this repo. To use them follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/your-org/deployment-config.git
    ```
2. cd into deployment-config
   ```bash
   cd deployment-config
   ```
3. copy the entire template subdirectory to a named service directory that works for you (optional)
   ```bash
   cp -r web-simple my-web-service
   ```
4. cd to the service directory
   ```bash
   cd my-web-service
   ```
5. copy the .env-template into a .env file
   ```bash
   cp .env-template .env
   ```
6. update the .env file with the desired environment variables
   ```bash
   vim .env
   ```
7. start the service
   ```bash
   docker compose up -d
   ```

<br/>

## Shared Services

The shared services, Traefik and Watchtower should be set up first. Traefik provides a shared Docker Compose network and acts as reverse proxy. This allows multiple Docker Composed based services to be hosted on the same VPS. Watchtower is a lightweight service the monitors the Docker repository and image of each service and automatically updates when a new image is available.


### Traefik
A couple environment variables are needed for Traefik. For the Traefik dashboard to work, you need a dashboard DNS and a user/password. An email address and certificated resolver are also required. Certificates are provided via Let's Encrypt. The cert resolver can be prod (for the Let's Encrypt production instance) or staging (for the Let's Encrypt staging instance). Note, only the prod instance actually provides a certificate. 

Here's an example .env file:
```bash
CERT_RESOLVER=prod
DASHBOARD_DNS=traefik.example.com
EMAIL_ADDRESS=myemailaddres@example.com
TRAEFIK_DASH_AUTH=admin:$$2y$$05$$DzhbeD1/jh4kjn32qwww6lkj4457njkj3
```


### Watch Tower
The environment variables for Watchtower are simple, only the polling interval is include. It defaults to 300 seconds if not provided.

This Watchtower template only watches services with the appropriate label set to true in its Docker Compose configuration. Add this label and set to true for services you want to update automatically:
```bash
- com.centurylinklabs.watchtower.enable=true
```

<br/>

## Custom Deployments

### Simple Website

The simple web template can work with any single-container web app and should for for any language. It is not intended to be used with an app requiring an on-host database or other infrastructure or on-host dependencies. Below are .env examples for a simple web app written in Python and Golang.


Python example:
```bash
APP_NAME=hello-py
CERT_RESOLVER=staging
DOCKER_IMAGE_NAME=ghcr.io/davidslusser/hello-py
DOCKER_IMAGE_TAG=latest
TRAEFIK_HOST_RULE=Host(`hello-py.example.com`)
WEB_PORT=8000
WEB_STARTUP_COMMAND="python app.py"
```

Golang example:
```bash
APP_NAME=hello-go
CERT_RESOLVER=staging
DOCKER_IMAGE_NAME=ghcr.io/davidslusser/hello-go
DOCKER_IMAGE_TAG=latest
TRAEFIK_HOST_RULE=Host(`hello-go.example.com`)
WEB_PORT=8000
WEB_STARTUP_COMMAND="./"
```

### Simple Django Service
The simple Django service template include a Django container and a Postgres container. Like the simple web service template it includes all the traefik labels needed to automatically set certificates from Let's Encrypt. 

The environment variables include values needed for the Docker Compose configuration, the Django application, and the Postgres container.

** Note: If you're going to be running more than one service with a Postgres database on your VPS, set a different port for each service (via the POSTGRES_HOST_PORT environment variable).


### Full-stack Django Service


<br/>

## Contributing

Contributions are welcome! Please submit a pull request or open an issue for suggestions.

<br/>

## License

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.
