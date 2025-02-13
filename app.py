from flask import Flask, request, render_template
import requests
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

DEEPSEEK_API_URL = "https://api.deepseek.com/v1/chat/completions"
DEEPSEEK_API_KEY = os.getenv("DEEPSEEK_API_KEY")

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        user_input = request.form.get("user_input")
        headers = {
            "Authorization": f"Bearer {DEEPSEEK_API_KEY}",
            "Content-Type": "application/json"
        }
        data = {
            "model": "deepseek-chat",
            "messages": [{"role": "user", "content": user_input}]
        }
        response = requests.post(DEEPSEEK_API_URL, json=data, headers=headers)
        if response.status_code == 200:
            result = response.json()["choices"][0]["message"]["content"]
        else:
            result = "Error: Unable to get a response from DeepSeek."
        return f'<div class="response-message">{result}</div>'
    return render_template("index.html")

if __name__ == "__main__":
    app.run(debug=True)