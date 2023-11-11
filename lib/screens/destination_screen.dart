import 'package:flutter/material.dart';

import '../model/destination.dart';


class DestinationScreen extends StatefulWidget {
  final Destination destination;

  DestinationScreen({required this.destination});

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  List<String> _activities = [
    'Sightseeing',
    'Hiking',
    'Beaches',
    'Museums',
    'Shopping',
  ];
  int _selectedActivityIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  widget.destination.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white),
                      SizedBox(width: 5),
                      Text(
                        widget.destination.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.destination.name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          SizedBox(width: 5),
                          Text(widget.destination.rating.toString()),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.destination.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Activities',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _activities.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedActivityIndex = index;
                              });
                            },
                            child: Chip(
                              label: Text(
                                _activities[index],
                                style: TextStyle(
                                  color: _selectedActivityIndex == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              backgroundColor: _selectedActivityIndex == index
                                  ? Theme
                                  .of(context)
                                  .colorScheme.secondary
                                  : Colors.grey[200],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.blue),
                          SizedBox(height: 5),
                          Text('Mar 2022'),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.people, color: Colors.blue),
                          SizedBox(height: 5),
                          Text(
                            "reviews"
                              // '${widget.destination.noOfReviews} Reviews'
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.star, color: Colors.blue),
                          SizedBox(height: 5),
                          Text(widget.destination.rating.toString()),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Theme
                          .of(context)
                          .colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    ),
                    child: Text(
                      'Explore',
                      style: TextStyle(fontSize: 18),
                    ),
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
