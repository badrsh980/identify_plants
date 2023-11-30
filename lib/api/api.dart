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
  Future<PlantIdentificationResponse> identifyPlantJson(List<String> images,
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
            'propagation_methods'
      ]}) async {
    final String detailsQuery = details.join(',');
    final Uri fullUrl =
        Uri.parse('$postApiUrl?details=$detailsQuery&language=$language');

    try {
      final response = await http.post(
        fullUrl,
        headers: {
          'Api-Key': apiKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'images': images}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(
            'Response Body post: ${response.body}'); // Print the response body
        return PlantIdentificationResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception: $e');
    }
  }
}
