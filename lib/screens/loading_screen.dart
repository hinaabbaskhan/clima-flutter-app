import 'dart:convert';

import 'package:clima_flutter_app/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> getWeatherData() async {
    //api call
    // status code check 200
    //get response body
    //jsonDecode conversion

    String _url =
        'https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b6907d289e10d714a6e88b30761fae22';
    http.Response response = await http.get(Uri.parse(_url));
    //statusCode and body
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      print(data["coord"]["lon"]);
      print(data["weather"][0]["description"]);

      // id, temp, name
    } else {
      print('API request failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Get the current location

            Location location = Location();
            await location.getCurrentLocation();
            print(location.longitude);
            print(location.latitude);

            getWeatherData();
          },
          child: Text('Get Weather'),
        ),
      ),
    );
  }
}

//
//api key: e89bd566819a99dbec331372a8855ae5
// https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22

//Future<bool> _handlePermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return false;
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return false;
//     }
//     return true;
//   }
