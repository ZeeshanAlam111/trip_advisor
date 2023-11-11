// import 'package:flutter/material.dart';
// import '../api_calls/counteries_api.dart';
//
// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   late Future<List<Country>> futureCountries;
//
//   @override
//   void initState() {
//     super.initState();
//     print('initState called');
//     futureCountries = CountryApi.fetchCountries();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Countries'),
//       ),
//       body: FutureBuilder<List<Country>>(
//         future: futureCountries,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return GridView.builder(
//               padding: EdgeInsets.all(10.0),
//               itemCount: snapshot.data!.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 10.0,
//                 crossAxisSpacing: 10.0,
//                 childAspectRatio: 1.0,
//               ),
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       snapshot.data![index].imageUrl != null
//                           ? Image.network(
//                         snapshot.data![index].imageUrl,
//                         height: 100.0,
//                         width: 100.0,
//                         fit: BoxFit.cover,
//                       )
//                           : Image.asset(
//                         'assets/images/placeholder.jpg',
//                         height: 100.0,
//                         width: 100.0,
//                         fit: BoxFit.cover,
//                       ),
//                       SizedBox(height: 10.0),
//                       Text(
//                         snapshot.data![index].name,
//                         style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 5.0),
//                       Text(
//                         snapshot.data![index].code,
//                         style: TextStyle(fontSize: 16.0),
//                       ),
//                     ],
//                   ),
//                 );
//
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
//













// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   late Future<List<Country>> futureCountries;
//
//   @override
//   void initState() {
//     super.initState();
//     futureCountries = fetchCountries();
//   }
//
//   Future<List<Country>> fetchCountries() async {
//     final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
//
//     if (response.statusCode == 200) {
//       List<dynamic> countriesJson = json.decode(response.body);
//       List<Country> countries = [];
//
//       for (var country in countriesJson) {
//         String countryName = country['name']['common'];
//         String countryCode = country['cca2'];
//
//         countries.add(
//           Country(
//             name: countryName,
//             code: countryCode,
//           ),
//         );
//       }
//
//       return countries;
//     } else {
//       throw Exception('Failed to load country data');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Countries'),
//       ),
//       body: FutureBuilder<List<Country>>(
//         future: futureCountries,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return GridView.builder(
//               padding: EdgeInsets.all(10.0),
//               itemCount: snapshot.data!.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 10.0,
//                 crossAxisSpacing: 10.0,
//                 childAspectRatio: 1.0,
//               ),
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         snapshot.data![index].name,
//                         style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 10.0),
//                       Text(
//                         snapshot.data![index].code,
//                         style: TextStyle(fontSize: 16.0),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
// class Country {
//   final String name;
//   final String code;
//
//   Country({
//     required this.name,
//     required this.code,
//   });
// }


import 'package:flutter/material.dart';


import '../model/city.dart';
import '../widgets/city_card.dart';
import 'city_screen.dart';

class MustVisitScreen extends StatelessWidget {
  final List<City> cities = [
    City(
      name: 'Paris',
      imageUrl: 'assets/images/paris.jpg',
    ),
    City(
      name: 'London',
      imageUrl: 'assets/images/london.jpg',
    ),
    City(
      name: 'New York',
      imageUrl: 'assets/images/new york.jpg',
    ),
    City(
      name: 'Sydney',
      imageUrl: 'assets/images/sydney.jpg',
    ),
    City(
      name: 'Tokyo',
      imageUrl: 'assets/images/tokyo.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Advisor'),
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (BuildContext context, int index) {
          final city = cities[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CityScreen(city: city),
                ),
              );
            },
            child: CityCard(city: city),
          );
        },
      ),
    );
  }
}
