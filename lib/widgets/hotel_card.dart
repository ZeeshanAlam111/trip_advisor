import 'package:flutter/material.dart';

class HotelCard extends StatelessWidget {
  final String name;
  final String location;
  final String imageUrl;
  final int reviewCount;
  final double rating;
  final double latitude;
  final double longitude;

  const HotelCard({
    Key? key,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.reviewCount,
    required this.rating,
    required this.latitude,
    required this.longitude
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: Text(name),
              subtitle: Text(location),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    rating.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('($reviewCount)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
