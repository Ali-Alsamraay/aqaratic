import 'dart:developer';

import 'package:aqaratak/providers/Maps_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import "package:google_maps_webservice/src/core.dart";
import "package:google_maps_webservice/src/places.dart";
import 'package:provider/provider.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FoodieMap();
  }
}

class FoodieMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FoodieMapState();
  }
}

class _FoodieMapState extends State<FoodieMap> {
  Position? _currentLocation;
  Set<Marker> _markers = {};
  // GoogleMapsPlaces? places;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        _currentLocation =
            await GeolocatorPlatform.instance.getCurrentPosition();
        final p = await _getGeoLocationPosition();
        await _retrieveNearbyRestaurants(
            LatLng(_currentLocation!.altitude, _currentLocation!.longitude));
      } catch (e) {}
    });
  }

  Future<void> _retrieveNearbyRestaurants(LatLng? _userLocation) async {
    Location location =
        Location(lat: _userLocation!.latitude, lng: _userLocation.longitude);
    // GoogleMapsPlaces places =
    //     GoogleMapsPlaces(apiKey: "AIzaSyA7hFegjTOWPDQB8v883B-au3ZDlYA1n1o");
    GoogleMapsPlaces places =
        GoogleMapsPlaces(apiKey: "AIzaSyBaPQDy3HnpZ_ML2mCVRcM4E_g_OWuF-Ao");
    // GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: "");
    PlacesSearchResponse _response =
        await places.searchNearbyWithRadius(location, 500, type: 'restaurant');

    // log(_response.results.first.types.toString());

    Set<Marker> _restaurantMarkers = _response.results
        .map((result) => Marker(
            markerId: MarkerId(result.name),
            // Use an icon with different colors to differentiate between current location
            // and the restaurants
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(
              title: result.name,
              snippet: "Ratings: " +
                  (result.rating == null
                      ? "Not Rated"
                      : result.rating.toString()),
            ),
            position: LatLng(
                result.geometry!.location.lat, result.geometry!.location.lng)))
        .toSet();

    setState(() {
      _markers.addAll(_restaurantMarkers);
    });
  }

  // Location of the Googleplex
  final _googlePlex = LatLng(37.4220, -122.0840);

  // Set of markers to be drawn on the map
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // _currentLocation =
          //     await GeolocatorPlatform.instance.getCurrentPosition();
          // await _retrieveNearbyRestaurants(
          //     LatLng(_currentLocation!.latitude, _currentLocation!.longitude));
          // Provider.of<MapsPlacesProvider>(context, listen: false)
          //     .getNearestMarkersbyLocation(
          //         LatLng(
          //             _currentLocation!.altitude, _currentLocation!.longitude),
          //         500,
          //         "");
          // setState(() {});


          // log(_markers.toString());
        },
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target:
              LatLng(_currentLocation!.latitude, _currentLocation!.longitude),
          zoom: 20.0,
        ),
        // Cascades notation that adds the Googleplex Marker in the markers set
        // and returns the reference to the set
        markers: Provider.of<MapsProvider>(context).nearestMarkers
          ..add(
            Marker(
              markerId: MarkerId("mine"),
              position: LatLng(
                  _currentLocation!.latitude, _currentLocation!.longitude),
            ),
          ),
      ),
    );
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
