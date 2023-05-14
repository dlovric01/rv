from flask import Flask, request, jsonify


app = Flask(__name__)


@app.route('/api/data', methods=['POST'])
def receive_data():
    data = request.json  # Assuming your Flutter app sends JSON data
    # Process the data as needed
    response = {'imageProcessed': data['image'],
                'name': 'sven', 'faceNotFound': 'true'}
    print(data)
    return jsonify(response), 200


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
