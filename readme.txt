# Build and start all services
docker compose up --build

# Start in detached mode
docker compose up -d

# Stop all services
docker compose down

# View logs
docker compose logs -f

# Rebuild specific service
docker compose build backend

./start-https.sh
open https://localhost:4443/