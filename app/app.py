from flask import Flask
import os

app = Flask(__name__)
env_name = os.environ.get("ENV_NAME", "default")

@app.route("/")
def home():
    return f"""
    <h1>Hello from {env_name.upper()} Environment!</h1>
    <p>This is a Blue-Green Deployment Demo</p>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)