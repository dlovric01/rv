import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:racunalni_vid/image_data.dart';

var url =
    'http://192.168.1.10:80/api/data'; // Replace with your Flask server URL

Future<ImageData> sendImageForProcessing(File file) async {
  try {
    List<int> imageBytes = await file.readAsBytes();
    String base64 = base64Encode(imageBytes);

    final body = {
      'image': base64,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    final sourceData = json.decode(response.body);

    final name = sourceData['name'];
    final bytes = base64Decode(sourceData['modified_image_data']);
    final processedFile = await File(file.path).writeAsBytes(bytes);

    return ImageData(
      file: processedFile,
      name: name != 'unknown' ? name : null,
      faceCount: sourceData['face_count'],
    );
  } catch (e) {
    rethrow;
  }
}
