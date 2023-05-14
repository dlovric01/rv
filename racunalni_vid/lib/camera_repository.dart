import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:racunalni_vid/image_data.dart';

var url =
    'http://192.168.1.10:80/api/data'; // Replace with your Flask server URL

Future<ImageData> sendImageForProcessing(File file) async {
  try {
    List<int> imageBytes = await file.readAsBytes();

    final body = {
      'image': imageBytes.toString(),
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    final sourceData = json.decode(response.body);
    final name = sourceData['name'];
    if (sourceData['faceNotFound'] == 'true') {
      throw Exception('Face not found');
    }
    final listOfBytes =
        jsonDecode((sourceData['imageProcessed'])) as List<dynamic>;

    final processedFileInBytes =
        listOfBytes.map<int>((value) => value as int).toList();

    final processedFile = File(file.path);
    await processedFile.writeAsBytes(processedFileInBytes);
    return ImageData(
      file: file,
      name: name != 'unknown' ? name : null,
    );
  } catch (e) {
    rethrow;
  }
}
