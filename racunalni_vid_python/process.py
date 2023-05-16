from flask import Flask, request, jsonify
import base64
import face_recognition
import cv2
import numpy as np
from supabase import create_client,Client
import uuid
from bla import get_last_user_data



supabase_url = "https://hlgiwyxivhxlkziqxgyp.supabase.co"
supabase_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhsZ2l3eXhpdmh4bGt6aXF4Z3lwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODQyNjM2MTEsImV4cCI6MTk5OTgzOTYxMX0.6D74Im4mZ4rLWU74A7qQqkfxdACApdj79vfjwv8b_Ko"
supabase: Client = create_client(supabase_url,supabase_key)

app = Flask(__name__)


@app.route('/process', methods=['POST'])
def process():
    data = request.json  # Assuming your Flutter app sends JSON data
    # Process the data as needed
    image_data_base64 = data['image']

    # Convert the base64-encoded image data to bytes
    image_data_bytes = base64.b64decode(image_data_base64)

    # Convert the bytes to a NumPy array
    image_array = np.frombuffer(image_data_bytes, dtype=np.uint8)

    # Decode the image array using OpenCV
    image = cv2.imdecode(image_array, cv2.IMREAD_COLOR)

    # Convert BGR image to RGB for face_recognition library
    rgb_image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

    # Detect faces in the image using face_recognition library
    face_locations = face_recognition.face_locations(rgb_image)

    # Draw rectangles around the detected faces
    for (top, right, bottom, left) in face_locations:
        cv2.rectangle(image, (left, top), (right, bottom), (0, 255, 0), 2)

    # Encode the modified image back to base64
    _, modified_image_data = cv2.imencode('.jpg', image)
    modified_image_base64 = base64.b64encode(
        modified_image_data).decode('utf-8')
    
    # Add modified_image_base64 to the response JSON
    response_data = {
        "modified_image_data": modified_image_base64,
        "face_count":len(face_locations)
    }

    return jsonify(response_data), 200

@app.route('/upload', methods=['POST'])
def upload():
    data = request.json  

    image_data_base64 = data['image']
    username = data['username']

    image_data = {
        "username": username,
        "image": image_data_base64,
    }
    supabase.table('users').insert(image_data).execute()

    return {
        "username": username,
        "image": image_data_base64
    }



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)


