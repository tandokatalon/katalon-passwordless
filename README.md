# Katalon Keycloak Theme with Bootstrap 5

This project includes a custom Keycloak theme that uses Bootstrap 5 for styling. The theme provides a modern, responsive login experience for users.

## Features

- Modern, responsive design using Bootstrap 5
- Custom styling for login, registration, and password reset pages
- Support for social login providers
- Customizable with your own logo and favicon
- Docker Compose setup for easy deployment with Keycloak 26.2.5 and PostgreSQL 17

## Directory Structure

```
src/main/resources/theme/katalon/
├── login/
│   ├── template.ftl             # Base template with reusable header and footer
│   ├── login.ftl                # Login page template
│   ├── register.ftl             # Registration page template
│   ├── password-reset.ftl       # Password reset page template
│   ├── theme.properties         # Theme configuration
│   └── resources/
│       ├── css/
│       │   └── styles.css       # Custom CSS styles
│       └── js/
│           └── script.js        # Custom JavaScript
```

## How to Use

1. Build the project using Gradle:
   ```
   ./gradlew build
   ```

2. Deploy the resulting JAR file to your Keycloak server's `standalone/deployments` directory.

3. In the Keycloak admin console:
   - Go to Realm Settings > Themes
   - Select "katalon" from the Login Theme dropdown
   - Click Save

4. Customize the theme (optional):
   - Add your logo by setting the `logoUrl` property in the theme.properties file
   - Add your favicon by setting the `favIcon` property in the theme.properties file

## Customization

You can customize the theme by modifying the following files:

- `template.ftl`: Base template with reusable header and footer
- `login.ftl`, `register.ftl`, `password-reset.ftl`: HTML templates for the pages
- `styles.css`: Custom CSS styles
- `script.js`: Custom JavaScript functionality
- `theme.properties`: Theme configuration properties

### Template Reuse

The theme uses a template system to reuse common elements across different pages:

- `template.ftl` contains the common structure including header and footer
- Each page template (login.ftl, register.ftl, etc.) imports the template and provides content for specific sections
- This approach ensures consistency across pages and makes maintenance easier

Example of how a page uses the template:

```ftl
<#import "template.ftl" as layout>

<@layout.registrationLayout 
    title=msg("pageTitle")
    header=msg("pageHeader")
    ; section>

    <#if section = "form">
        <!-- Form content here -->
    </#if>

    <#if section = "script">
        <!-- Page-specific scripts here -->
    </#if>
</@layout.registrationLayout>
```

## Bootstrap 5 Integration

The theme uses Bootstrap 5 locally:

```html
<link href="${url.resourcesPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${url.resourcesPath}/js/bootstrap.bundle.min.js"></script>
```

The Bootstrap files are included in the project at:
- `resources/css/bootstrap.min.css`
- `resources/js/bootstrap.bundle.min.js`

This ensures that the theme works without requiring an internet connection and improves loading performance.

## Docker Setup

This project includes a Docker Compose configuration to easily run Keycloak with the custom theme.

### Prerequisites

- Docker and Docker Compose installed on your system
- Git (to clone this repository)

### Building and Running with Docker

#### Quick Start

For a quick start, you can use the provided test script:
```bash
./test-docker-setup.sh
```

This script will build the project, start the Docker Compose services, and check if Keycloak is accessible.

#### Manual Setup

1. **Build the theme JAR file**:
   ```bash
   # Build using local Gradle
   ./gradlew build

   # OR build using Docker
   docker build -t katalon-theme-builder .
   docker cp $(docker create --name temp-container katalon-theme-builder:latest):/katalon-passwordless-1.0-SNAPSHOT.jar ./build/libs/
   docker rm temp-container
   ```

2. **Start Keycloak and PostgreSQL with Docker Compose**:
   ```bash
   docker-compose up -d
   ```

3. **Access Keycloak**:
   - Open your browser and navigate to: http://localhost:8080/
   - Log in to the admin console with:
     - Username: `admin`
     - Password: `admin`

4. **Apply the Custom Theme**:
   - Go to Realm Settings > Themes
   - Select "katalon" from the Login Theme dropdown
   - Click Save

### Docker Compose Configuration

The Docker Compose setup includes:

- **PostgreSQL 17**: Database for Keycloak
  - Credentials: Username: `keycloak`, Password: `password`
  - Data is persisted in a Docker volume

- **Keycloak 26.2.5**: Identity and Access Management
  - Admin credentials: Username: `admin`, Password: `admin`
  - The custom theme JAR is mounted into the Keycloak container

### Stopping the Services

To stop the Docker Compose services:
```bash
docker-compose down
```

To stop and remove all data (including the PostgreSQL volume):
```bash
docker-compose down -v
```
