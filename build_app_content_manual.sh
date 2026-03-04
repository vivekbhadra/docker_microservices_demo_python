cd ~/docker_microservices_demo_python/microservices-demo

# ── data-service/app.py ──────────────────────────────────────────
cat > data-service/app.py << 'EOF'
import logging
import os
from flask import Flask, jsonify

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s"
)
logger = logging.getLogger("data-service")
app = Flask(__name__)

@app.route("/health")
def health():
    return jsonify({"status": "ok", "service": "data-service"})

@app.route("/data")
def get_data():
    logger.info("Data requested")
    return jsonify({
        "service": "data-service",
        "message": "Hello from data service",
        "items": [
            {"id": 1, "name": "Widget A", "value": 42},
            {"id": 2, "name": "Widget B", "value": 99},
        ]
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)
EOF

# ── data-service/requirements.txt ───────────────────────────────
cat > data-service/requirements.txt << 'EOF'
flask==3.0.3
EOF

# ── data-service/Dockerfile ──────────────────────────────────────
cat > data-service/Dockerfile << 'EOF'
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .
ENV PORT=5001
EXPOSE 5001
CMD ["python", "app.py"]
EOF

# ── api-service/app.py ───────────────────────────────────────────
cat > api-service/app.py << 'EOF'
import logging
import os
import requests
from flask import Flask, jsonify

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s"
)
logger = logging.getLogger("api-service")
app = Flask(__name__)

DATA_SERVICE_URL = os.getenv("DATA_SERVICE_URL", "http://data-service:5001")

@app.route("/health")
def health():
    data_health = requests.get(f"{DATA_SERVICE_URL}/health", timeout=5).json()
    return jsonify({"status": "ok", "data-service": data_health.get("status")})

@app.route("/api/data")
def get_data():
    logger.info("Request received: GET /api/data")
    data = requests.get(f"{DATA_SERVICE_URL}/data", timeout=5).json()
    return jsonify({"service": "api-service", "data": data})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF

# ── api-service/requirements.txt ────────────────────────────────
cat > api-service/requirements.txt << 'EOF'
flask==3.0.3
requests==2.32.3
EOF

# ── api-service/Dockerfile ───────────────────────────────────────
cat > api-service/Dockerfile << 'EOF'
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .
ENV PORT=5000
ENV DATA_SERVICE_URL=http://data-service:5001
EXPOSE 5000
CMD ["python", "app.py"]
EOF

# ── docker-compose.yml ───────────────────────────────────────────
cat > docker-compose.yml << 'EOF'
services:

  data-service:
    build: ./data-service
    container_name: data-service
    environment:
      - PORT=5001
    networks:
      - microservices-net
    restart: unless-stopped

  api-service:
    build: ./api-service
    container_name: api-service
    ports:
      - "5000:5000"
    environment:
      - PORT=5000
      - DATA_SERVICE_URL=http://data-service:5001
    depends_on:
      - data-service
    networks:
      - microservices-net
    restart: unless-stopped

networks:
  microservices-net:
    driver: bridge
EOF
