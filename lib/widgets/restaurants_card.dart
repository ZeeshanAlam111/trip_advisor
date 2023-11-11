import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String location;
  final String imageUrl;
  final int reviewCount;
  final double rating;
  final double latitude;
  final double longitude;


  const RestaurantCard({
    Key? key,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.reviewCount,
    required this.rating, required this.latitude, required this.longitude,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: AspectRatio(
        aspectRatio: 0.7, // Adjust the aspect ratio as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
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
