import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AttractionCard extends StatelessWidget {
  final String name;
  final String location;
  final String imageUrl;
  final int reviewCount;
  final double rating;
  final String? writeReview;
  final bool love;
  final double latitude;
  final double longitude;

  const AttractionCard({
    Key? key,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.reviewCount,
    required this.rating,
    this.writeReview,
    this.love=false,
    required this.longitude,
    required this.latitude

  }) : super(key: key);

  factory AttractionCard.fromJson(Map<String, dynamic> json) {
    return AttractionCard(
      name: json['name'],
      location: json['location_string'],
      imageUrl: json['photo']['images']['original']['url'],
      reviewCount: json['num_reviews'],
      rating: json['rating'],
      writeReview: json['write_review'],
      love: false, latitude: json['latitude'], longitude: json['longitude'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
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
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    launch('https://www.tripadvisor.com');
                  },
                  child: Text('View on TripAdvisor'),
                ),
                TextButton(
                  onPressed: () {
                    launch(writeReview!);
                  },
                  child: Text('Write Review'),
                ),
              ],
            ),
            IconButton(
              onPressed: () async {
                final updatedLoveStatus = !love;

                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  final userCollection = FirebaseFirestore.instance.collection('users');
                  final userDocument = userCollection.doc(user.uid);
                  final attractionsRef = userDocument.collection('attractions');

                  if (updatedLoveStatus) {
                    attractionsRef.add({
                      'name': name,
                      'location': location,
                      'imageUrl': imageUrl,
                      'reviewCount': reviewCount,
                      'rating': rating,
                      'writeReview': writeReview,
                    });
                  } else {
                    final snapshot = await attractionsRef
                        .where('name', isEqualTo: name)
                        .where('location', isEqualTo: location)
                        .limit(1)
                        .get();

                    for (final doc in snapshot.docs) {
                      await doc.reference.delete();
                    }
                  }
                }
              },
              icon: Icon(
                love ? Icons.favorite : Icons.favorite_border,
                color: love ? Colors.red : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
