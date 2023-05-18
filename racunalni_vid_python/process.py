from flask import Flask, request, jsonify
import base64
import cv2
from supabase import create_client,Client
from functions import get_list_of_recognized_users,get_image_details,append_username_to_image,cut_image_for_upload

supabase_url = "https://hlgiwyxivhxlkziqxgyp.supabase.co"
supabase_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhsZ2l3eXhpdmh4bGt6aXF4Z3lwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODQyNjM2MTEsImV4cCI6MTk5OTgzOTYxMX0.6D74Im4mZ4rLWU74A7qQqkfxdACApdj79vfjwv8b_Ko"
supabase: Client = create_client(supabase_url,supabase_key)

app = Flask(__name__)


@app.route('/process', methods=['POST'])
def process():
    # Retrieve the image data in Base64 format from the JSON payload
    image_data_base64 = request.json['image']

    # Get the face locations, RGB image, and original image details
    face_locations, rgb_image, image = get_image_details(image_data_base64)

    # Get the list of recognized usernames based on the face locations
    usernames = get_list_of_recognized_users(rgb_image, face_locations)

    # Iterate over each face location and draw rectangles on the image
    for index, (top, right, bottom, left) in enumerate(face_locations):
        cv2.rectangle(image, (left, top), (right, bottom), (0, 255, 0), 2)

        # If a username exists for the current face, append it to the image
        if usernames[index]:
            append_username_to_image(left, right, top, bottom, usernames, index, image)

    # Encode the modified image as JPEG and convert it to Base64 format
    _, modified_image_data = cv2.imencode('.jpg', image)
    modified_image_base64 = base64.b64encode(modified_image_data).decode('utf-8')

    # Check if a single face exists with a recognized username
    exists = False
    if len(face_locations) == 1:
        if usernames[0] != None:
            exists = True

    # Prepare the response data with the modified image, face count, and exists flag
    response_data = {
        "modified_image_data": modified_image_base64,
        "face_count": len(face_locations),
        "exists": exists
    }

    # Return the response as JSON with an HTTP status code of 200
    return jsonify(response_data), 200


@app.route('/upload', methods=['POST'])
def upload():
    # Extract the data from the request's JSON payload
    data = request.json

    # Retrieve the image data and username from the JSON data
    image_data_base64 = data['image']
    username = data['username']

    # Perform any necessary processing on the image data (e.g., resizing, cropping, etc.)
    image = cut_image_for_upload(image_data_base64)

    # Create a dictionary with the username and processed image data
    image_data = {
        "username": username,
        "image": image,
    }

    # Insert the image data into the 'users' table in the Supabase database
    supabase.table('users').insert(image_data).execute()

    # Return a response with the username and original image data
    return {
        "username": username,
        "image": image_data_base64
    }

if __name__ == '__main__':
    # Start the Flask app on host 0.0.0.0 and port 80
    app.run(host='0.0.0.0', port=80)


