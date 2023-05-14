import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

var url =
    'http://192.168.1.10:80/api/data'; // Replace with your Flask server URL

Future<File> sendImageForProcessing(File file) async {
  try {
    List<int> imageBytes = await file.readAsBytes();
    print(imageBytes);

    final body = {
      'image': imageBytes.toString(),
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    print(response);
    final sourceData = json.decode(response.body);
    final listOfBytes =
        jsonDecode((sourceData['imageProcessed'])) as List<dynamic>;

    final processedFileInBytes =
        listOfBytes.map<int>((value) => value as int).toList();

    final processedFile = File(file.path);
    await processedFile.writeAsBytes(processedFileInBytes);
    return processedFile;
  } catch (e) {
    print(e);
    rethrow;
  }
}
