from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/message', methods=['POST'])
def respond():
    data = request.json
    message = data.get('message', '')
    
    if message == "HELLO CS 616":
        response = "Voila! You got it right..."
    else:
        response = "Oops... That's does not look legitimate!"
    
    return jsonify({'response': response})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)