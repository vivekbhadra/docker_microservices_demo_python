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

SERVICE_NAME = os.getenv("SERVICE_NAME", "api-service")
PORT = int(os.getenv("PORT", 5000))
DATA_SERVICE_URL = os.getenv("DATA_SERVICE_URL", "http://data-service:5001")


def fetch_from_data_service(path: str) -> dict:
    url = f"{DATA_SERVICE_URL}{path}"
    logger.info(f"Calling data-service: {url}")
    try:
        response = requests.get(url, timeout=5)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.ConnectionError:
        logger.error(f"Cannot connect to data-service at {url}")
        return {"error": "data-service unavailable"}
    except requests.exceptions.Timeout:
        logger.error("data-service request timed out")
        return {"error": "data-service timeout"}
    except requests.exceptions.HTTPError as e:
        logger.error(f"data-service returned error: {e}")
        return {"error": str(e)}


@app.route("/health")
def health():
    logger.info("Health check requested")
    data_health = fetch_from_data_service("/health")
    return jsonify({
        "status": "ok",
        "service": SERVICE_NAME,
        "dependencies": {
            "data-service": data_health.get("status", "unknown")
        }
    })


@app.route("/api/data")
def get_data():
    logger.info("Request received: GET /api/data")
    data = fetch_from_data_service("/data")
    return jsonify({
        "service": SERVICE_NAME,
        "data": data
    })


if __name__ == "__main__":
    logger.info(f"Starting {SERVICE_NAME} on port {PORT}")
    logger.info(f"Data service URL: {DATA_SERVICE_URL}")
    app.run(host="0.0.0.0", port=PORT)
