


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_advisor/screens/hotel_detail_screen.dart';
import 'package:travel_advisor/screens/restaurant_detail_screen.dart';
import 'package:travel_advisor/widgets/hotel_card.dart';
import '../api_calls/hotel_api.dart';
import '../widgets/attraction_card.dart';
import '../widgets/restaurants_card.dart';
import 'attraction_detail_screen.dart';
import 'maps.dart';

enum FilterOptions { restaurants, hotels, attractions } // Add this enum

class HotelScreen extends StatefulWidget {
  @override
  _HotelScreenState createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  late Future<List<dynamic>> futureTravelCards;
  FilterOptions selectedFilter = FilterOptions.restaurants;

  @override
  void initState() {
    super.initState();
    fetchData(selectedFilter);
  }

  void fetchData(FilterOptions filter) {
    switch (filter) {
      case FilterOptions.hotels:
        futureTravelCards = fetchHotels();
        break;
      case FilterOptions.attractions:
        futureTravelCards = fetchAttractions();
        break;
      default:
        futureTravelCards = fetchRestaurants();
    }
  }

  void navigateToMapScreen(double? latitude, double? longitude) {
    if (latitude != null && longitude != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapScreen(latitude: latitude, longitude: longitude),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Advisor'),
        actions: [
          DropdownButton<FilterOptions>(
            value: selectedFilter,
            onChanged: (FilterOptions? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedFilter = newValue;
                  fetchData(newValue);
                });
              }
            },
            items: [
              DropdownMenuItem<FilterOptions>(
                value: FilterOptions.restaurants,
                child: Text('Restaurants'),
              ),
              DropdownMenuItem<FilterOptions>(
                value: FilterOptions.hotels,
                child: Text('Hotels'),
              ),
              DropdownMenuItem<FilterOptions>(
                value: FilterOptions.attractions,
                child: Text('Attractions'),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureTravelCards,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          if (snapshot.data![index] is RestaurantCard) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestaurantDetail(
                                  restaurantCard: snapshot.data![index],
                                ),
                              ),
                            );
                          } else if (snapshot.data![index] is HotelCard) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HotelDetailScreen(
                                  hotelCard: snapshot.data![index],
                                ),
                              ),
                            );
                          } else if (snapshot.data![index] is AttractionCard) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AttractionDetail(
                                  attractionCard: snapshot.data![index],
                                ),
                              ),
                            );
                          }
                        },
                        child: selectedFilter == FilterOptions.restaurants
                            ? RestaurantCard(
                          latitude: snapshot.data![index].latitude,
                          name: snapshot.data![index].name,
                          location: snapshot.data![index].location,
                          imageUrl: snapshot.data![index].imageUrl,
                          reviewCount: snapshot.data![index].reviewCount,
                          rating: snapshot.data![index].rating, longitude: snapshot.data![index].longitude,
                        )
                            : selectedFilter == FilterOptions.hotels
                            ? HotelCard(
                          name: snapshot.data![index].name,
                          location: snapshot.data![index].location,
                          imageUrl: snapshot.data![index].imageUrl,
                          reviewCount: snapshot.data![index].reviewCount,
                          rating: snapshot.data![index].rating,latitude: snapshot.data![index].latitude, longitude: snapshot.data![index].longitude,
                        )
                            : AttractionCard(
                          name: snapshot.data![index].name,
                          location: snapshot.data![index].location,
                          imageUrl: snapshot.data![index].imageUrl,
                          reviewCount: snapshot.data![index].reviewCount,
                          rating: snapshot.data![index].rating,
                          latitude: snapshot.data![index].latitude, longitude: snapshot.data![index].longitude,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: InkWell(
                          onTap: () {
                            print(snapshot.data![index].latitude);
                            print(snapshot.data![index].longitude);
                            if (snapshot.data![index] is RestaurantCard ||
                                snapshot.data![index] is HotelCard ||
                                snapshot.data![index] is AttractionCard) {
                              navigateToMapScreen(
                                snapshot.data![index].latitude,
                                snapshot.data![index].longitude,
                              );
                            }
                          },
                          child: Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
