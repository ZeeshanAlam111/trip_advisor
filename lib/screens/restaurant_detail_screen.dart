// restaurant_detail.dart
import 'package:flutter/material.dart';
import '../widgets/restaurants_card.dart';

class RestaurantDetail extends StatefulWidget {
  final RestaurantCard restaurantCard;

  RestaurantDetail({required this.restaurantCard});

  @override
  _RestaurantDetailState createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurantCard.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.restaurantCard.imageUrl),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.restaurantCard.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.restaurantCard.location,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Rating: ${widget.restaurantCard.rating}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Review Count: ${widget.restaurantCard.reviewCount}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
