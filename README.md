# Katalon Keycloak Passwordless

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

1. **Start Keycloak and PostgreSQL with Docker Compose**:
   ```bash
   docker-compose up -d
   ```

2. **Access Keycloak**:
   - Open your browser and navigate to: http://localhost:8080/
   - Log in to the admin console with:
     - Username: `admin`
     - Password: `admin`

### Docker Compose Configuration

The Docker Compose setup includes:

- **PostgreSQL 17**: Database for Keycloak
  - Credentials: Username: `keycloak`, Password: `password`
  - Data is persisted in a Docker volume

- **Keycloak 26.2.5**: Identity and Access Management
  - Admin credentials: Username: `admin`, Password: `admin`

### Stopping the Services

To stop the Docker Compose services:
```bash
docker-compose down
```

To stop and remove all data (including the PostgreSQL volume):
```bash
docker-compose down -v
```
