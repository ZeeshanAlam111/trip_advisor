import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/attraction_card.dart';
import '../widgets/hotel_card.dart';
import '../widgets/restaurants_card.dart';


// 'latitude': '37.19983',
// 'longitude': '-122.084',


Future<List<RestaurantCard>> fetchRestaurants() async {

  // Position position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);


  final String apiKey = '14a234757amshc4a4dffd0d521f4p1791ddjsn44344eae2cc0';
  final String host = 'travel-advisor.p.rapidapi.com';

  final Uri uri = Uri.https(
    host,
    '/restaurants/list-by-latlng',
    {
      'latitude': '34.032519',
      'longitude': '71.535841',
      'limit': '30',
      'currency': 'USD',
      'distance': '2',
      'open_now': 'false',
      'lunit': 'km',
      'lang': 'en_US',
    },
  );

  final response = await http.get(
    uri,
    headers: {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': host,
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    List<dynamic> items = jsonResponse['data'];
    return items.map<RestaurantCard>((item) {
      // Parse the JSON response and create RestaurantCard objects
      // You need to replace the keys in the item map with the correct keys from the restaurant data

      double latitude = (item['latitude'] != null) ? double.parse(item['latitude'].toString()) : 0.0;
      double longitude = (item['longitude'] != null) ? double.parse(item['longitude'].toString()) : 0.0;


      String imageUrl = (item['photo'] != null && item['photo']['images'] != null && item['photo']['images']['large'] != null)
          ? item['photo']['images']['large']['url']
          : 'https://via.placeholder.com/550x318'; // Provide a default placeholder image URL

      double rating = (item['rating'] != null) ? double.parse(item['rating'].toString()) : 0.0;

      int reviewCount = (item['num_reviews'] != null) ? int.parse(item['num_reviews'].toString()) : 0;

      // Add other necessary fields from the restaurant data

      return RestaurantCard(
        latitude: latitude,
        longitude: longitude,
        name: item['name'] ?? '',
        location: item['location_string'] ?? '',
        imageUrl: imageUrl,
        rating: rating,
        reviewCount: reviewCount,
        // Add other necessary fields as arguments for the RestaurantCard constructor
      );
    }).toList();
  } else {
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    throw Exception('Failed to load restaurant data');
  }
}

Future<List<HotelCard>> fetchHotels() async {
  final String apiKey = '14a234757amshc4a4dffd0d521f4p1791ddjsn44344eae2cc0';
  final String host = 'travel-advisor.p.rapidapi.com';
  final Uri uri = Uri.https(host,
      '/hotels/list-by-latlng', {
        'latitude': '34.032519',
        'longitude': '71.535841',
        'limit': '30',
        'currency': 'USD',
        'distance': '2',
        'open_now': 'false',
        'lunit': 'km',
        'lang': 'en_US',
      });

  final response = await http.get(
    uri,
    headers: {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': host,
    },
  );
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    List<dynamic> items = jsonResponse['data'];
    return items.map((item) {
      // Update the JSON parsing as needed for the hotel data
      // Replace the keys in the item map with the correct keys from the hotel data

      double latitude = (item['latitude'] != null) ? double.parse(item['latitude'].toString()) : 0.0;
      double longitude = (item['longitude'] != null) ? double.parse(item['longitude'].toString()) : 0.0;


      String imageUrl = (item['photo'] != null && item['photo']['images'] != null && item['photo']['images']['large'] != null)
          ? item['photo']['images']['large']['url']
          : 'https://via.placeholder.com/550x318'; // Provide a default placeholder image URL

      double rating = (item['rating'] != null) ? double.parse(item['rating']) : 0.0;

      int reviewCount = (item['num_reviews'] != null) ? int.parse(item['num_reviews']) : 0;

      return HotelCard(
        latitude: latitude,
        longitude: longitude,
        name: item['name'] ?? '',
        location: item['location_string'] ?? '',
        imageUrl: imageUrl,
        rating: rating,
        reviewCount: reviewCount,
      );
    }).toList();
  } else {
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    throw Exception('Failed to load hotel data');
  }
}


Future<List<AttractionCard>> fetchAttractions() async {
  final String apiKey = '14a234757amshc4a4dffd0d521f4p1791ddjsn44344eae2cc0';
  final String host = 'travel-advisor.p.rapidapi.com';

  final Uri uri = Uri.https(
    host,
    '/attractions/list-by-latlng',
    {
      'latitude': '34.032519',
      'longitude': '71.535841',
      'lunit': 'km',
      'currency': 'USD',
      'lang': 'en_US',
    },
  );

  final response = await http.get(
    uri,
    headers: {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': host,
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    List<dynamic> items = jsonResponse['data'];
    return items.map<AttractionCard>((item) {

      double latitude = (item['latitude'] != null) ? double.parse(item['latitude'].toString()) : 0.0;
      double longitude = (item['longitude'] != null) ? double.parse(item['longitude'].toString()) : 0.0;


      String imageUrl = (item['photo'] != null && item['photo']['images'] != null && item['photo']['images']['large'] != null)
          ? item['photo']['images']['large']['url']
          : 'https://via.placeholder.com/550x318'; // Provide a default placeholder image URL

      double rating = (item['rating'] != null) ? double.parse(item['rating'].toString()) : 0.0;

      int reviewCount = (item['num_reviews'] != null) ? int.parse(item['num_reviews'].toString()) : 0;

      String webUrl = item['web_url'] ?? '';
      String writeReviewUrl = item['write_review'] ?? '';


      return AttractionCard(
        name: item['name'] ?? '',
        location: item['location_string'] ?? '',
        imageUrl: imageUrl,
        rating: rating,
        reviewCount: reviewCount,
        writeReview: writeReviewUrl,
        latitude: latitude,
        longitude: longitude,
      );
    }).toList();
  } else {
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    throw Exception('Failed to load attraction data');
  }
}
