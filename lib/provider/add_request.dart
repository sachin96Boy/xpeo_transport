import 'dart:convert';

import 'package:http/http.dart' as http;

class Request {
  static Future<dynamic> getRequest(String url) async {
    var response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        return responseData;
      } else {
        return "Failed";
      }
    } catch (error) {
      return "Failed";
      print(error);
    }
  }
}
