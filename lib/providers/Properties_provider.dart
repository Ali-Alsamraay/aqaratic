import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/Property_Category.dart';
import '../models/property.dart';
import 'package:sizer/sizer.dart';

class PropertiesProvider with ChangeNotifier {
  List<Property> _properties = [];
  List<PropertyCategory> _categories = [];
  List<Property> _filteredProperties = [];
  List<Property> _filteredPropertiesForMap = [];
  Set<Marker> _markers = new Set();
  int? currentPage = 1;
  bool? getting_more_data = false;
  int? selectedCategoryId = 1;

  List<PropertyCategory> get categories => [..._categories];
  List<Property> get properties => [..._properties];
  List<Property> get filteredProperties => [..._filteredProperties];
  List<Property> get filteredPropertiesForMap => [..._filteredPropertiesForMap];
  Set<Marker> get markers => _markers;

  final List<Map<String, dynamic>>? property_types_items = [
    {
      "id": 1,
      "title": "أراضي",
      "slug": "land",
      "icon_path": "assets/images/land_icon.svg",
    },
    {
      "id": 3,
      "title": "عماير",
      "slug": "buildings",
      "icon_path": "assets/images/building_icon.svg",
    },
    {
      "id": 4,
      "title": "فيلا",
      "slug": "villa",
      "icon_path": "assets/images/villa_icon.svg",
    },
  ];

  Property? getPropertyById(int? id) {
    return _properties.firstWhere((element) => element.id == id);
  }

  void searchByTitle(String? keyWord) {
    if (keyWord!.trim().isEmpty) {
      _filteredProperties = _properties;
      notifyListeners();
      return;
    }
    ;
    // search about property..
    _filteredProperties = _properties
        .where(
          (element) => element.title!.toString().toLowerCase().contains(
                keyWord.trim().toLowerCase(),
              ),
        )
        .toList();
    notifyListeners();
  }

  void selecteCategory(int? id) {
    // select filtered properties..
    _filteredProperties = _properties.where((element) {
      return element.property_type!['id'] == id;
    }).toList();
    notifyListeners();
  }

  Future<void> get_markers_on_map(int? categoryId) async {
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

  Future<void> get_properties_with_categories() async {
    try {
      final url = Uri.parse(
        'https://aqaratic.digitalfuture.sa/api/v1/mobile/properties?page=1',
      );
      // Await the http get response, then decode the json-formatted response.
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "application/json",
          "Accept-Encoding": "gzip, deflate, br",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            convert.jsonDecode(response.body);

        final List<dynamic> loadedPrprties = jsonResponse['data'];
        _properties = loadedPrprties.map((property) {
          final Property propertyData = Property.fromJson(
            property,
          );
          return propertyData;
        }).toList();

        if (_filteredProperties.isEmpty) {
          selecteCategory(1);
          return;
        }
        notifyListeners();
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  Future<void> get_more_properties_with_categories() async {
    try {
      currentPage = currentPage! + 1;
      getting_more_data = true;
      final url = Uri.parse(
        'https://aqaratic.digitalfuture.sa/api/v1/mobile/properties?page=$currentPage',
      );
      // Await the http get response, then decode the json-formatted response.
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "application/json",
          "Accept-Encoding": "gzip, deflate, br",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            convert.jsonDecode(response.body);

        final List<dynamic> loadedPrprties = jsonResponse['data'];
        getting_more_data = false;
        if (loadedPrprties.isEmpty) {
          currentPage = currentPage! - 1;
          return;
        }
        _properties.addAll(
          loadedPrprties.map((property) {
            final Property propertyData = Property.fromJson(property);
            return propertyData;
          }).toList(),
        );
        selecteCategory(selectedCategoryId);
      } else {}
    } catch (e) {
      rethrow;
    }
  }
}
