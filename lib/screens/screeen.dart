import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiKey = '14a234757amshc4a4dffd0d521f4p1791ddjsn44344eae2cc0';

class CityScreen extends StatefulWidget {
  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  List<City> cities = [];

  @override
  void initState() {
    super.initState();
    fetchCities();
  }

  Future<void> fetchCities() async {
    const url =
        'https://travel-advisor.p.rapidapi.com/locations/v2/search?currency=USD&units=km&lang=en_US';

    try {
      final response = await http.post(Uri.parse(url), headers: {
        'content-type': 'application/json',
        'X-RapidAPI-Key': apiKey,
        'X-RapidAPI-Host': 'travel-advisor.p.rapidapi.com',
      }, body: jsonEncode({
        'query': 'chiang mai',
        'updateToken': '',
      }));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final citiesData = responseData['data'];

        setState(() {
          cities = citiesData.map<City>((e) => City.fromJson(e)).toList();
        });
      } else {
        print('Error fetching cities: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching cities: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cities'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final city = cities[index];

          return Card(
            child: ListTile(
              leading: city.imageUrl != null ? Image.network(city.imageUrl!) : null,
              title: Text(city.name ?? ''),
            ),
          );
        },
      ),
    );
  }
}

class City {
  final String? id;
  final String? name;
  final String? country;
  final String? latitude;
  final String? longitude;
  final String? imageUrl;

  City({
    this.id,
    this.name,
    this.country,
    this.latitude,
    this.longitude,
    this.imageUrl,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['location_id'],
      name: json['name'],
      country: json['country'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      imageUrl: json['photo'] != null ? json['photo']['images']['small']['url'] : null,
    );
  }
}
