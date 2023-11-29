import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:identify_plants/model/plant.dart';

String api = 'rQhxSnQCDm3F75ifhNySYxUevdu2sCdBdkMAwIjpFBo73zeCe6';

class PlantIdService {
  final String apiKey;
  static const String postApiUrl = 'https://plant.id/api/v3/identification';
  static const String getApiBaseUrl = 'https://plant.id/api/v3/identification/';

  PlantIdService(this.apiKey);

  // POST method for identifying plants
  Future<PlantIdentificationResponse> identifyPlantJson(
      List<String> images) async {
    try {
      final response = await http.post(
        Uri.parse(postApiUrl),
        headers: {
          'Api-Key': apiKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'images': images}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Assuming status code 201 is also a successful response
        return PlantIdentificationResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception: $e');
    }
  }

  // GET method to retrieve detailed information using the access_token
  Future<dynamic> getPlantDetails(String accessToken,
      {String language = 'en',
      List<String> details = const [
        'common_names',
        'url',
        'description',
        'taxonomy',
        'rank',
        'gbif_id',
        'inaturalist_id',
        'image',
        'synonyms',
        'edible_parts',
        'watering'
      ]}) async {
    final Uri fullUrl =
        Uri.parse(getApiBaseUrl + accessToken).replace(queryParameters: {
      'details': details.join(','),
      'language': language,
    });

    try {
      final response = await http.get(
        fullUrl,
        headers: {
          'Api-Key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception: $e');
    }
  }
}
