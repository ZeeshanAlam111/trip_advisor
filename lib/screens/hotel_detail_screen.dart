// hotel_detail.dart
import 'package:flutter/material.dart';
import '../widgets/hotel_card.dart';

class HotelDetailScreen extends StatefulWidget {
  final HotelCard hotelCard;

  HotelDetailScreen({required this.hotelCard});

  @override
  _HotelDetailScreenState createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hotelCard.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.hotelCard.imageUrl),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.hotelCard.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.hotelCard.location,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Rating: ${widget.hotelCard.rating}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Review Count: ${widget.hotelCard.reviewCount}',
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

