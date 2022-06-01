import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

import '../models/property.dart';
import 'package:sizer/sizer.dart';

class MapsProvider with ChangeNotifier {
  Set<Marker> _nearestMarkers = {};
  Set<Marker> _markers = new Set();
  List<Property> _filteredPropertiesForMap = [];

  Set<Marker> get markers => _markers;
  Set<Marker> get nearestMarkers => _nearestMarkers;
  List<Property> get filteredPropertiesForMap => [..._filteredPropertiesForMap];



  Future<void> get_all_markers_on_map(List<Property> _properties) async {
    List<Marker>? allMarkers = await Future.wait<Marker>(
      _properties.map((Property property) async {
        String? markerPath = "assets/icons/aradi_marker.png";
        if (property.property_type!['id'] == 1) {
          markerPath = "assets/icons/aradi_marker.png";
        } else if (property.property_type!['id'] == 3) {
          markerPath = "assets/icons/amarat_marker.png";
        } else if (property.property_type!['id'] == 4) {
          markerPath = "assets/icons/villa_marker.png";
        }

        final BitmapDescriptor iconMarker =
            await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
            size: Size(1.0.w, 2.0.h),
          ),
          markerPath,
        );
        return Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(property.id.toString()),
          position: LatLng(
            property.latitude!,
            property.longitude!,
          ),
          infoWindow: InfoWindow(
            title: property.title,
            snippet: property.description,
          ),
          icon: iconMarker,
        );
      }).toSet(),
    );
    _markers = allMarkers.toSet();
    notifyListeners();
  }

  Future<void> get_markers_for_category_on_map(int? categoryId,List<Property> _properties, ) async {
    if (categoryId == -1) {
      await get_all_markers_on_map(_properties);
      return;
    }
    _filteredPropertiesForMap = _properties.where((element) {
      return element.property_type!['id'] == categoryId;
    }).toList();

    String? markerPath = "assets/icons/aradi_marker.png";
    if (categoryId == 1) {
      markerPath = "assets/icons/aradi_marker.png";
    } else if (categoryId == 3) {
      markerPath = "assets/icons/amarat_marker.png";
    } else if (categoryId == 4) {
      markerPath = "assets/icons/villa_marker.png";
    }

    // final String iconMarkerUrl = 'your url';

    // final http.Response request = await http.get(Uri.parse(iconMarkerUrl));
    // final Uint8List bytes = request.bodyBytes;

    // final BitmapDescriptor iconMarker = BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());

    final BitmapDescriptor iconMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(1.0.w, 2.0.h),
      ),
      markerPath,
    );

    _markers = _filteredPropertiesForMap.map((Property property) {
      return Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(property.id.toString()),
        position: LatLng(
          property.latitude!,
          property.longitude!,
        ),
        infoWindow: InfoWindow(
          title: property.title,
          snippet: property.description,
        ),
        icon: iconMarker,
      );
    }).toSet();

    notifyListeners();
  }

  Future<void> getNearestMarkersbyLocation(
    LatLng? location,
    double rangeRadius,
    String? placeType,
  ) async {
    final GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: "AIzaSyBaPQDy3HnpZ_ML2mCVRcM4E_g_OWuF-Ao",
    );
    final PlacesSearchResponse _response = await places.searchNearbyWithRadius(
      Location(
        lat: location!.latitude,
        lng: location.longitude,
      ),
      500,
      keyword: "cafe",
    );
    log(_response.results.first.types.toString());

    _nearestMarkers = _response.results
        .map(
          (result) => Marker(
            markerId: MarkerId(
              result.name,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueMagenta,
            ),
            infoWindow: InfoWindow(
              title: result.name,
              snippet:
                  result.rating == null ? "غير مقيم" : result.rating.toString(),
            ),
            position: LatLng(
              result.geometry!.location.lat,
              result.geometry!.location.lng,
            ),
          ),
        )
        .toSet();
    notifyListeners();
  }

  List<String>? get getPlacesTypes {
    return [
      "accounting",
      "airport",
      "amusement_park",
      "aquarium",
      "art_gallery",
      "atm",
      "bakery",
      "bank",
      "bar",
      "beauty_salon",
      "bicycle_store",
      "book_store",
      "bowling_alley",
      "bus_station",
      "cafe",
      "campground",
      "car_dealer",
      "car_rental",
      "car_repair",
      "car_wash",
      "casino",
      "cemetery",
      "church",
      "city_hall",
      "clothing_store",
      "convenience_store",
      "courthouse",
      "dentist",
      "department_store",
      "doctor",
      "drugstore",
      "electrician",
      "electronics_store",
      "embassy",
      "fire_station",
      "florist",
      "funeral_home",
      "furniture_store",
      "gas_station",
      "gym",
      "hair_care",
      "hardware_store",
      "hindu_temple",
      "home_goods_store",
      "hospital",
      "insurance_agency",
      "jewelry_store",
      "laundry",
      "lawyer",
      "library",
      "light_rail_station",
      "liquor_store",
      "local_government_office",
      "locksmith",
      "lodging",
      "meal_delivery",
      "meal_takeaway",
      "mosque",
      "movie_rental",
      "movie_theater",
      "moving_company",
      "museum",
      "night_club",
      "painter",
      "park",
      "parking",
      "pet_store",
      "pharmacy",
      "physiotherapist",
      "plumber",
      "police",
      "post_office",
      "primary_school",
      "real_estate_agenc",
      "restaurant",
      "roofing_contracto",
      "rv_park",
      "school",
      "secondary_school",
      "shoe_store",
      "shopping_mall",
      "spa",
      "stadium",
      "storage",
      "store",
      "subway_station",
      "supermarket",
      "synagogue",
      "taxi_stand",
      "tourist_attraction",
      "train_station",
      "transit_station",
      "travel_agency",
      "university",
      "veterinary_care",
      "zoo",
    ];
  }
}
