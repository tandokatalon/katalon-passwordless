#!/bin/bash
set -e

echo "=== Building the project ==="
./gradlew build

echo "=== Starting Docker Compose services ==="
docker-compose up -d

echo "=== Waiting for Keycloak to start (this may take a minute) ==="
for i in {1..30}; do
  if curl -s http://localhost:8080/ > /dev/null; then
    echo "Keycloak is up and running!"
    echo "You can access the admin console at: http://localhost:8080/admin/"
    echo "Username: admin"
    echo "Password: admin"
    echo ""
    echo "To apply the custom theme:"
    echo "1. Log in to the admin console"
    echo "2. Go to Realm Settings > Themes"
    echo "3. Select 'katalon' from the Login Theme dropdown"
    echo "4. Click Save"
    exit 0
  fi
  echo "Waiting for Keycloak to start... ($i/30)"
  sleep 10
done

echo "Timed out waiting for Keycloak to start. Check the logs with 'docker-compose logs keycloak'"
exit 1