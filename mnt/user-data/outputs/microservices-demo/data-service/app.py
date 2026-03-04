import logging
import os
from flask import Flask, jsonify

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s"
)
logger = logging.getLogger("data-service")

app = Flask(__name__)

SERVICE_NAME = os.getenv("SERVICE_NAME", "data-service")
PORT = int(os.getenv("PORT", 5001))


@app.route("/health")
def health():
    logger.info("Health check requested")
    return jsonify({"status": "ok", "service": SERVICE_NAME})


@app.route("/data")
def get_data():
    logger.info("Data requested")
    return jsonify({
        "service": SERVICE_NAME,
        "message": "Hello from data service",
        "items": [
            {"id": 1, "name": "Widget A", "value": 42},
            {"id": 2, "name": "Widget B", "value": 99},
            {"id": 3, "name": "Widget C", "value": 7},
        ]
    })


if __name__ == "__main__":
    logger.info(f"Starting {SERVICE_NAME} on port {PORT}")
    app.run(host="0.0.0.0", port=PORT)
