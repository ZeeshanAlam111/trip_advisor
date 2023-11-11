import 'dart:convert';
import 'package:http/http.dart' as http;

class TravelAdvisorApi {
  static const String _baseUrl = 'https://travel-advisor.p.rapidapi.com';
  static const String _apiKey = '14a234757amshc4a4dffd0d521f4p1791ddjsn44344eae2cc0';

  Future<List<dynamic>> getBestPlacesToVisit(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/locations/search?query=best%20places%20to%20visit&latitude=$latitude&longitude=$longitude'),
      headers: {
        'x-rapidapi-host': 'travel-advisor.p.rapidapi.com',
        'x-rapidapi-key': _apiKey,
      },
    );

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      return decodedResponse['data'];
    } else {
      throw Exception('Failed to fetch best places to visit');
    }
  }
}
