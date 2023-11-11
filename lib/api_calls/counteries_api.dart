import 'package:http/http.dart' as http;
import 'dart:convert';

class Country {
  final String name;
  final String code;
  final String imageUrl;

  Country({
    required this.name,
    required this.code,
    required this.imageUrl,
  });
}

class CountryApi {
  static Future<List<Country>> fetchCountries() async {
    final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      List<dynamic> countriesJson = json.decode(response.body);
      List<Country> countries = [];

      for (var country in countriesJson) {
        String countryName = country['name']['common'];
        String countryCode = country['cca2'];

        // Obtain the image URL from Unsplash
        try {

          final unsplashResponse = await http.get(Uri.parse('https://api.unsplash.com/search/photos?query=$countryName&client_id=<gAgrr-IpM_5PoVenCSf2tzkMbe1eRvSWvicnIWJZtFY>'));
          print(unsplashResponse.body);
          final unsplashJson = json.decode(unsplashResponse.body);

          final imageUrl = unsplashJson['results'][0]['urls']['regular'];
          print('Country: $countryName, Image URL: $imageUrl');
          countries.add(
            Country(
              name: countryName,
              code: countryCode,
              imageUrl: imageUrl,
            ),
          );
        } catch (e) {
          print('Error fetching image for country $countryName: $e');
        }
      }

      return countries;
    } else {
      throw Exception('Failed to load country data');
    }
  }
}

















// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// Future<List<Country>> fetchCountries() async {
//   final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
//
//   if (response.statusCode == 200) {
//     List<dynamic> countriesJson = json.decode(response.body);
//     List<Country> countries = [];
//
//     for (var country in countriesJson) {
//       String countryName = country['name']['common'];
//       String countryCode = country['cca2'];
//       String imageUrl = await fetchCountryImageUrl(countryName);
//
//       countries.add(
//         Country(
//           name: countryName,
//           code: countryCode,
//           imageUrl: imageUrl,
//         ),
//       );
//     }
//
//     return countries;
//   } else {
//     throw Exception('Failed to load country data');
//   }
// }
//
// Future<String> fetchCountryImageUrl(String countryName) async {
//   String unsplashApiKey = '44gZrvzA38R0h7Kkrz5VdZBpj-YVrSHXCo1SPZZj-Xo';
//   String searchUrl =
//       'https://api.unsplash.com/search/photos?query=$countryName&client_id=$unsplashApiKey&per_page=1';
//
//   final response = await http.get(Uri.parse(searchUrl));
//
//   if (response.statusCode == 200) {
//     Map<String, dynamic> imageJson = json.decode(response.body);
//
//     if (imageJson['results'].length > 0) {
//       return imageJson['results'][0]['urls']['small'];
//     } else {
//       return 'https://via.placeholder.com/300'; // Fallback image URL
//     }
//   } else {
//     throw Exception('Failed to load image data');
//   }
// }
// class Country {
//   final String name;
//   final String code;
//   final String imageUrl;
//
//   Country({
//     required this.name,
//     required this.code,
//     required this.imageUrl,
//   });
// }
