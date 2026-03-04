# Microservices Demo

A minimal two-service Python microservices architecture using Flask and Docker.

## Architecture

```
Client
   │
localhost:5000
   │
API Service (container)        ← publicly exposed
   │
Docker Network (microservices-net)
   │
Data Service (container)       ← internal only
```

## Services

| Service      | Port | Exposed | Description                          |
|-------------|------|---------|--------------------------------------|
| api-service  | 5000 | ✅ Yes  | Accepts client requests, calls data-service |
| data-service | 5001 | ❌ No   | Returns business data as JSON        |

## Endpoints

### API Service (public)
| Method | Path        | Description                        |
|--------|-------------|------------------------------------|
| GET    | /api/data   | Returns data fetched from data-service |
| GET    | /health     | Returns health status of both services |

### Data Service (internal)
| Method | Path    | Description          |
|--------|---------|----------------------|
| GET    | /data   | Returns business data |
| GET    | /health | Returns health status |

## Quick Start

### Prerequisites
- Docker
- Docker Compose

### Run locally

```bash
# Build and start both services
docker compose up --build

# Run in background
docker compose up --build -d
```

### Test

```bash
# Main endpoint
curl http://localhost:5000/api/data

# Health check (includes data-service status)
curl http://localhost:5000/health
```

### Stop

```bash
docker compose down
```

## Configuration

All configuration is via environment variables — never hardcoded.

| Variable          | Service     | Default                      | Description              |
|------------------|-------------|------------------------------|--------------------------|
| SERVICE_NAME      | Both        | api-service / data-service   | Service identifier       |
| PORT              | Both        | 5000 / 5001                  | Listening port           |
| DATA_SERVICE_URL  | api-service | http://data-service:5001     | Internal data-service URL |

Override in `docker-compose.yml` or pass via `-e` flags.

## Project Structure

```
microservices-demo/
│
├── api-service/
│   ├── app.py              # Flask app — calls data-service
│   ├── requirements.txt    # flask, requests
│   └── Dockerfile
│
├── data-service/
│   ├── app.py              # Flask app — returns JSON data
│   ├── requirements.txt    # flask
│   └── Dockerfile
│
├── docker-compose.yml      # Orchestrates both services
└── README.md
```

## Next Steps

- [ ] Add a database service (PostgreSQL)
- [ ] Add API authentication (JWT or API keys)
- [ ] Add structured/centralised logging
- [ ] Add a message queue (RabbitMQ or Redis)
- [ ] Push images to DockerHub or AWS ECR
- [ ] Deploy to AWS ECS or Kubernetes
- [ ] Replace data-service with C++ implementation if performance needed
