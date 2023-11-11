import 'package:flutter/material.dart';
import 'package:travel_advisor/screens/home.dart';
import 'package:travel_advisor/screens/hotels.dart';
import 'maps.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    MustVisitScreen(),
     MapScreen(),
    HotelScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.map),
            label: 'Maps',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.location_on),
            label: 'Locations',
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Home Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }