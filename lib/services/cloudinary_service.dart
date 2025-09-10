import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  static const String cloudName = 'dzy7tz8ye';
  static const String uploadPreset = 'foodgo';
  static const String apiKeyt = '928324544338522';
  static const String apiSecret = 'P6UnIemG89Yisw4aTlDaAN6RiDU';

  // Uplpad Function
  static Future<String?> uploadImage(File imageFile) async {
    try {
      final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
      );
      final request = http.MultipartRequest("POST", url)
        ..fields["upload_preset"] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath("file", imageFile.path));
      final response = await request.send();
      if (response.statusCode == 200) {
        final responsedata = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responsedata);
        final jsonmap = jsonDecode(responseString);
        return jsonmap["secure_url"] as String;
      }
    } catch (e) {
      print(e);
    }
  }
}
