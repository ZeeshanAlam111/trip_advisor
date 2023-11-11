import 'package:flutter/material.dart';

import '../model/city.dart';
import '../model/destination.dart';
import '../widgets/destination_tile.dart';

class CityScreen extends StatelessWidget {
  final City city;
  final List<Destination> destinations = [
    Destination(
      imageUrl: 'assets/images/Louvre Museum.jpg',
      name: 'Louvre Museum',
      rating: 4.5,
      description: 'Art museum in Paris, France',
    ),
    Destination(
      imageUrl: 'assets/images/big ben.jpg',
      name: 'Big Ben',
      rating: 4.8,
      description: 'Clock tower in London, England',
    ),
    Destination(
      imageUrl: 'assets/images/statue of Liberty_3.jpg',
      name: 'Statue of Liberty',
      rating: 4.7,
      description: 'Iconic national monument in New York City',
    ),
    Destination(
      imageUrl: 'assets/images/sydney opera house.jpg',
      name: 'Sydney Opera House',
      rating: 4.6,
      description: 'Iconic performing arts center in Sydney, Australia',
    ),
    Destination(
      imageUrl: 'assets/images/tokyo tower.jpg',
      name: 'Tokyo Tower',
      rating: 4.4,
      description: 'Landmark tower in Tokyo, Japan',
    ),
  ];

  CityScreen({required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(city.name),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(city.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: destinations.length,
              itemBuilder: (BuildContext context, int index) {
                final destination = destinations[index];

                return DestinationTile(destination: destination);
              },
            ),
          ),
        ],
      ),
    );
  }
}
