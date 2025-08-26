from flask import Flask, jsonify

app = Flask(__name__)

@app.get("/")
def home():
    return jsonify({
        "service": "solar-system",
        "message": "Hello, world!",
        "version": "1.0.0"
    })

@app.get("/health")
def health():
    return jsonify({"status": "ok"}), 200

if __name__ == "__main__":
    # For local debugging; in production we use gunicorn
    app.run(host="0.0.0.0", port=5000)
