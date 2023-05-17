from flask import Flask, request, jsonify
import base64
import face_recognition
import cv2
import numpy as np
from supabase import create_client,Client
import uuid
from bla import get_list_of_recognized_users,get_image_details,append_username_to_image,cut_image_for_upload
import os

os.environ['DEBUG'] = '1'

supabase_url = "https://hlgiwyxivhxlkziqxgyp.supabase.co"
supabase_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhsZ2l3eXhpdmh4bGt6aXF4Z3lwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODQyNjM2MTEsImV4cCI6MTk5OTgzOTYxMX0.6D74Im4mZ4rLWU74A7qQqkfxdACApdj79vfjwv8b_Ko"
supabase: Client = create_client(supabase_url,supabase_key)

app = Flask(__name__)


@app.route('/process', methods=['POST'])
def process():
    data = request.json 
    image_data_base64 = data['image']

    face_locations,rgb_image,image = get_image_details(image_data_base64)

    usernames = get_list_of_recognized_users(rgb_image,face_locations)

    for index,(top, right, bottom, left) in enumerate(face_locations):
        
        cv2.rectangle(image, (left, top), (right, bottom), (0, 255, 0), 2)

        if(usernames[index]):
            append_username_to_image(left,right,top,bottom,usernames,index,image)


    # Encode the modified image back to base64
    _, modified_image_data = cv2.imencode('.jpg', image)
    modified_image_base64 = base64.b64encode(
        modified_image_data).decode('utf-8')
    

    exists = False
    if(len(face_locations)==1):
        if(usernames[0]!=None):   
            exists=True

    
    # Add modified_image_base64 to the response JSON
    response_data = {
        "modified_image_data": modified_image_base64,
        "face_count":len(face_locations),
        "exists": exists
    }

    return jsonify(response_data), 200

@app.route('/upload', methods=['POST'])
def upload():
    data = request.json  

    image_data_base64 = data['image']
    username = data['username']

    image = cut_image_for_upload(image_data_base64)

    image_data = {
        "username": username,
        "image": image,
    }
    supabase.table('users').insert(image_data).execute()

    return {
        "username": username,
        "image": image_data_base64
    }



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)


