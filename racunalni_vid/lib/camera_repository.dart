import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:racunalni_vid/image_data.dart';

var url = 'http://192.168.1.7:80'; // Replace with your Flask server URL

Future<ImageData> sendImageForProcessing(File file) async {
  try {
    List<int> imageBytes = await file.readAsBytes();
    String base64 = base64Encode(imageBytes);

    final body = {
      'image': base64,
    };

    final response = await http.post(
      Uri.parse('$url/process'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    final sourceData = json.decode(response.body);

    final name = sourceData['name'];
    final bytes = base64Decode(sourceData['modified_image_data']);

    // Generate a new unique file path for the processed file
    final processedFilePath = '${file.path}_processed';

    final processedFile = await File(processedFilePath).writeAsBytes(bytes);

    return ImageData(
      initialFile: file,
      processedFile: processedFile,
      name: name != 'unknown' ? name : null,
      faceCount: sourceData['face_count'],
      exists: sourceData['exists'],
    );
  } catch (e) {
    rethrow;
  }
}

Future<ImageData> addUserToDatabase(File file, String username) async {
  List<int> imageBytes = await file.readAsBytes();
  String base64 = base64Encode(imageBytes);
  final body = {
    'username': username,
    'image': base64,
  };

  final response = await http.post(
    Uri.parse('$url/upload'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(body),
  );

  final sourceData = json.decode(response.body);

  final name = sourceData['username'];
  final bytes = base64Decode(sourceData['image']);
  // Generate a new unique file path for the processed file
  final processedFilePath = '${file.path}_processed_uploaded';

  final processedFile = await File(processedFilePath).writeAsBytes(bytes);
  return ImageData(
    initialFile: file,
    processedFile: processedFile,
    name: name,
    faceCount: sourceData['face_count'],
  );
}
