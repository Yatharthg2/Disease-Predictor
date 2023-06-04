import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

// SHOW DOCTOR

/*
However, you need to replace YOUR_API_KEY with your actual API key for the
Google Places API. You can obtain an API key by following the instructions
on the Google Cloud Console.

Remember to replace the YOUR_API_KEY placeholder with your actual API key
from Google Places API.
*/

class DermatologistPage extends StatefulWidget {
  const DermatologistPage({Key? key}) : super(key: key);

  @override
  _DermatologistPageState createState() => _DermatologistPageState();
}

class _DermatologistPageState extends State<DermatologistPage> {
  List _dermatologists = [];

  @override
  void initState() {
    super.initState();
    fetchDermatologists();
  }

  Future<void> fetchDermatologists() async {
    // Get the user's current location
    Position position = await Geolocator.getCurrentPosition();
    double latitude = position.latitude;
    double longitude = position.longitude;

    // Define the search radius (in meters)
    int radius = 5000;

    // Use the Google Places API to find dermatologists
    // within the search radius of the user's location
    // TODO: Replace YOUR_API_KEY with your actual API key
    String url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=$latitude,$longitude'
        '&radius=$radius'
        '&type=doctor'
        '&keyword=dermatologist'
        '&key=https://npiregistry.cms.hhs.gov/api/?city=San%20Francisco&state=CA&taxonomy_description=Dermatology&limit=10&version=2.1';

    // Send an HTTP request to the Google Places API
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Parse the JSON response and extract the list of dermatologists
      var json = jsonDecode(response.body);
      var results = json['results'];
      setState(() {
        _dermatologists = results;
      });
    } else {
      print('Failed to get dermatologists');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dermatologists'),
      ),
      body: _dermatologists.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _dermatologists.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_dermatologists[index]['name'] ?? ''),
                  subtitle: Text(_dermatologists[index]['vicinity'] ?? ''),
                );
              },
            ),
    );
  }
}
