// attraction_detail.dart
import 'package:flutter/material.dart';

import '../widgets/attraction_card.dart';


class AttractionDetail extends StatefulWidget {
  final AttractionCard attractionCard;

  AttractionDetail({required this.attractionCard});

  @override
  _AttractionDetailState createState() => _AttractionDetailState();
}

class _AttractionDetailState extends State<AttractionDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.attractionCard.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.attractionCard.imageUrl),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.attractionCard.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.attractionCard.location,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Rating: ${widget.attractionCard.rating}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Review Count: ${widget.attractionCard.reviewCount}',
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
