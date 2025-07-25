import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class UploadImage {
  static Future<String> uploadImage(File image) async {
    final url = Uri.parse("https://api.hireanything.com/uploads/");
    final request = http.MultipartRequest('POST', url);
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image.path,
      ),
    );

    final res = await request.send().timeout(const Duration(seconds: 30));
    final response = await http.Response.fromStream(res);
    print(response.body);
    final json = jsonDecode(response.body);
    return json["image_paths"][0];
  }
}
