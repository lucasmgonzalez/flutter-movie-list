import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class API {
  Future<Map<String, dynamic>> get(path, {Map<String, String> queryParams}) async {
    Map<String, String> queryParameters = {
      'api_key': env['TMDB_API_KEY']
    };

    if (queryParams != null) {
      queryParameters.addAll(queryParams);
    }

    var uri = Uri.https("api.themoviedb.org", path, queryParameters);

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to make request');
    }
  }
}