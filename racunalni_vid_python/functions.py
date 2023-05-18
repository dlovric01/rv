import base64
import face_recognition
import cv2
import numpy as np
from supabase import create_client,Client
import os

os.environ['DEBUG'] = '1'

supabase_url = "https://hlgiwyxivhxlkziqxgyp.supabase.co"
supabase_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhsZ2l3eXhpdmh4bGt6aXF4Z3lwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODQyNjM2MTEsImV4cCI6MTk5OTgzOTYxMX0.6D74Im4mZ4rLWU74A7qQqkfxdACApdj79vfjwv8b_Ko"
supabase: Client = create_client(supabase_url,supabase_key)


def get_image_details(image_data_base64):
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
    return face_locations,rgb_image,image


def get_list_of_recognized_users(rgb_image, face_locations):
    # Create a query to retrieve all records from the 'users' table in the Supabase database
    query = supabase.from_('users').select('*')
    
    # Execute the query and get the result
    result = query.execute()

    # Create an empty list to store the known images from the result
    known_images = []

    # Extract the 'image' field from each record in the result and add it to the list of known images
    for i in result.data:
        known_images.append(i['image'])

    # Compare the known images with the RGB image and face locations to identify matches
    usernameIndexes, recognizedFaceIndexes = compare(known_images, rgb_image, face_locations)

    # Create an empty list to store the usernames of recognized users
    usernames = []

    # Extract the usernames corresponding to the matched face indexes
    for i in usernameIndexes:
        usernames.append(result.data[i]['username'])

    # Create a list with None values, one for each face location
    returnable = [None] * len(face_locations)

    # Assign the usernames to the respective face locations in the returnable list
    for index, i in enumerate(recognizedFaceIndexes):
        returnable[i] = usernames[index]

    # Return the list of recognized users
    return returnable



def compare(images, rgb_image_unknown, face_locations_unknown):
    # Create an empty list to store the known face encodings
    known_encodings = []

    # Iterate over the list of known images
    for i in images:
        # Decode the base64 image data and convert it to a numpy array
        image_data_bytes = base64.b64decode(i)
        image_array = np.frombuffer(image_data_bytes, dtype=np.uint8)

        # Decode the image array and convert it to RGB format
        image = cv2.imdecode(image_array, cv2.IMREAD_COLOR)
        rgb_image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

        # Locate faces in the RGB image and compute face encodings
        face_locations = face_recognition.face_locations(rgb_image)
        face_encodings = face_recognition.face_encodings(rgb_image, face_locations)[0]

        # Add the face encodings to the list of known encodings
        known_encodings.append(face_encodings)

    # Compute face encodings for the unknown RGB image and face locations
    face_encodings = face_recognition.face_encodings(rgb_image_unknown, face_locations_unknown)

    # Create empty lists to store the indexes of recognized usernames and recognized face indexes
    usernameIndexes = []
    recognizedFaceIndexes = []

    # Compare the unknown face encodings with the known encodings
    for index, i in enumerate(face_encodings):
        result = face_recognition.compare_faces(known_encodings, i, tolerance=0.6)
        print(result)

        try:
            # Find the index of the first True value in the result list
            recognizedUserIndex = result.index(True)

            # Append the recognized user index and face index to the respective lists
            usernameIndexes.append(recognizedUserIndex)
            recognizedFaceIndexes.append(index)
        except ValueError:
            print("No maching faces found.")

    # Return the lists of recognized usernames and recognized face indexes
    return usernameIndexes, recognizedFaceIndexes
    

def append_username_to_image(left,right,top,bottom,usernames,index,image):
    text_top = bottom + int(0.1 * (bottom - top))  # Adjust the vertical position of the text
    text_height = int(0.03 * (bottom - top))  # Adjust the text height based on the rectangle height

    # Define the font scale based on the text height
    font_scale = text_height / 5  # Adjust the scaling factor as needed
    align_text = left + (right - left) // 3

    # Calculate the text size using OpenCV
    text_size, _ = cv2.getTextSize(usernames[index], cv2.FONT_HERSHEY_SIMPLEX, font_scale, 2)

    # Calculate the background rectangle dimensions
    background_left = align_text
    background_top = text_top - text_size[1]   # Adjust the padding as needed
    background_right = align_text + text_size[0]
    background_bottom = text_top

    # Draw the black background rectangle
    cv2.rectangle(image, (background_left, background_top), (background_right, background_bottom), (0, 0, 0), cv2.FILLED)

    # Add the text to the image
    font_thickness = 2  # Adjust the font thickness as needed
    cv2.putText(image, usernames[index], (align_text, text_top), cv2.FONT_HERSHEY_SIMPLEX, font_scale, (0, 255, 0), font_thickness, cv2.LINE_AA)



def cut_image_for_upload(image_data_base64):
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

    
    # Select the first face location
    top, right, bottom, left = face_locations[0]
    padding = 100  # Adjust the padding value as needed
    top -= padding
    right += padding
    bottom += padding
    left -= padding

    # Ensure the cropped region stays within the image boundaries
    top = max(0, top)
    right = min(image.shape[1], right)
    bottom = min(image.shape[0], bottom)
    left = max(0, left)

    # Crop the image to the region of interest (face)
    face_image = image[top:bottom, left:right]

    # Convert the face image to base64 encoding
    _, face_image_data = cv2.imencode('.png', face_image)
    face_image_base64 = base64.b64encode(face_image_data).decode()

    return face_image_base64