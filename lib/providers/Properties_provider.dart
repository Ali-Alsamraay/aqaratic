import 'dart:developer';

import 'package:aqaratak/providers/Auth_Provider.dart';
import 'package:aqaratak/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:convert' as convert;
import '../helper/constants.dart';
import '../models/Property_Field.dart';
import '../models/Property_Type.dart';
import '../models/property.dart';

class PropertiesProvider with ChangeNotifier {
  List<Property> _properties = [];
  List<PropertyType> _propertyTypes = [];
  List<Property> _filteredProperties = [];
  List<Property> _featuredProperties = [];
  List<Property> _filteredPropertiesWithPrams = [];

  List<PropertyField> _propertiesFields = [];

  List<dynamic> _propertyTypes_Objects = [];
  List<dynamic>? _cities_Objects = [];
  List<dynamic>? _purposes_Objects = [];
  List<dynamic>? _aminities_Objects = [];
  List<dynamic>? _nearest_locations_Objects = [];
  List<dynamic>? _periods_Objects = [];
  String? formInitErrorMsg = null;
  List<dynamic>? formResponseErrorMsgs = [];

  List<PropertyType> get propertyTypes => [..._propertyTypes];
  List<Property> get properties => [..._properties];
  List<Property> get filteredProperties => [..._filteredProperties];
  List<Property> get featuredProperties => [..._featuredProperties];
  List<Property> get filteredPropertiesWithPrams =>
      [..._filteredPropertiesWithPrams];

  List<PropertyField> get propertiesFields => [..._propertiesFields];

  List<dynamic> get propertyTypes_Objects => [..._propertyTypes_Objects];
  List<dynamic> get cities_Objects => [..._cities_Objects!];
  List<dynamic> get purposes_Objects => [..._purposes_Objects!];
  List<dynamic> get aminities_Objects => [..._aminities_Objects!];
  List<dynamic> get nearest_locations_Objects =>
      [..._nearest_locations_Objects!];
  List<dynamic> get periods_Objects => [..._periods_Objects!];

  SfRangeValues? priceRangeValues = SfRangeValues(0, 100);
  SfRangeValues? areaRangeValues = SfRangeValues(0, 100);

  int? currentPage = 1;
  int? currentPageForFiltration = 1;
  bool? getting_more_data = false;
  int? selectedCategoryId = -1;
  Property? propertyToBeUploaded = Property();

  Map<String, dynamic> _filtration_prams = {
    "search": "",
    "propertyTypeData": "",
    "country": "",
    "cityId": "",
    "countryStats": "",
    "construction_period": "",
    "floors": "",
    "rooms": "",
    "aminity[]": [],
    "kitchens": "",
    "min_size": "",
    "max_size": "",
    "numberOfBedroom": "",
    "min_price": "",
    "max_price": "",
    "propertyFor": "",
    "method_type": "",
  };

  Map<String, dynamic> get filtration_prams => {..._filtration_prams};

  void set_filtration_prams(String updated_filtration_pram, String key) {
    _filtration_prams[key] = updated_filtration_pram;
    notifyListeners();
  }

  void set_amenities_filtration_prams(
    List<dynamic> updated_amenities,
  ) {
    _filtration_prams["aminity[]"] = [...updated_amenities];
    notifyListeners();
  }

  Map<String, dynamic> get_amenities_by_property_type(
    List<dynamic> property_types,
    String property_type_id,
    String amenities_key_name,
    Map<String, dynamic> all_amenities,
  ) {
    final Map<String, dynamic>? property = property_types.firstWhere(
        (element) => element['id'].toString() == property_type_id,
        orElse: () => null);
    if (property == null) return all_amenities;
    return property[amenities_key_name];
  }

  Map<String, dynamic> get_selected_amenity_names(
    Map<String, dynamic> all_amenities,
  ) {
    final Map<String, dynamic>? amenities = {};
    all_amenities.forEach(
      (key, value) {
        if (_filtration_prams["aminity[]"].toList().contains(key)) {
          amenities!.addAll(
            {
              key: value,
            },
          );
        }
      },
    );
    return amenities!;
  }

  final List<Map<String, dynamic>>? property_types_items = [
    {
      "id": -1,
      "title": "????????",
      "slug": "all",
    },
    {
      "id": 1,
      "title": "??????????",
      "slug": "land",
      "icon_path": "assets/images/land_icon.svg",
    },
    {
      "id": 3,
      "title": "??????????",
      "slug": "buildings",
      "icon_path": "assets/images/building_icon.svg",
    },
    {
      "id": 4,
      "title": "????????",
      "slug": "villa",
      "icon_path": "assets/images/villa_icon.svg",
    },
    {
      "id": 19,
      "title": "??????",
      "slug": "villa",
      "icon_path": "assets/images/building_icon.svg",
    },
  ];

  void cleare_form_data() {
    _aminities_Objects = [];
    _cities_Objects = [];
    _nearest_locations_Objects = [];
    _propertiesFields = [];
    _propertyTypes = [];
    _purposes_Objects = [];
    _propertyTypes_Objects = [];
  }

  void setPriceRangeValues(SfRangeValues value) {
    if (priceRangeValues != null) {
      priceRangeValues = value;
      notifyListeners();
    }
  }

  void setAreaRangeValues(SfRangeValues value) {
    if (areaRangeValues != null) {
      areaRangeValues = value;
      notifyListeners();
    }
  }

  double getMaxPrice() {
    //  find max price in properties
    double maxPrice = 0;
    for (var property in _properties) {
      if (property.price! > maxPrice) {
        maxPrice = property.price!;
      }
    }
    return maxPrice;
  }

  double getMaxArea() {
    //  find max area in properties
    double maxArea = 0;
    for (var property in _properties) {
      if (property.area! > maxArea) {
        maxArea = property.area!;
      }
    }
    return maxArea;
  }

  Property? getPropertyById(int? id) {
    return _properties.firstWhere(
      (element) => element.id == id,
    );
  }

  String? get_Label_Text_By_Lang_key(String? langKey) {
    return _propertiesFields
        .firstWhere(
          (element) => element.lang_key == langKey,
          orElse: () => PropertyField(
            labelText: "unknown label text",
          ),
        )
        .labelText;
  }

  PropertyField? get_Property_Field_By_Lang_key(String? langKey) {
    return _propertiesFields.firstWhere(
      (element) => element.lang_key == langKey,
      orElse: () => PropertyField(),
    );
  }

  List<PropertyField>? get_Filled_Property_Field() {
    return _propertiesFields
        .where(
          (element) => element.value != null && element.value != "",
        )
        .toList();
  }

  Future<void> get_Property_Form(BuildContext context) async {
    try {
      formInitErrorMsg == null;
      final String? token = await AuthProvider().getUserToken();
      if (token == null || token == "") {
        Navigator.of(context).pushNamed(LoginScreen.screenName);
        return;
      }
      final url = Uri.parse(
        baseUrl + '/api/v1/mobile/user/properties/create',
      );

      // Await the http post response.
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "application/json",
          "Accept-Encoding": "gzip, deflate, br",
          "Authorization": "bearer " + token
        },
      );

      final Map<String, dynamic> jsonResponse =
          convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        // get fields names
        final List<dynamic> responseJson = jsonResponse['websiteLang'] == null
            ? []
            : jsonResponse['websiteLang'];
        _propertiesFields = responseJson.map((propertyField) {
          final PropertyField propertyObject = PropertyField.fromJson(
            propertyField,
          );
          return propertyObject;
        }).toList();

        // get_properties_types..
        final List<dynamic> loadedProperties =
            jsonResponse['propertyTypes'] == null
                ? []
                : jsonResponse['propertyTypes'];

        _propertyTypes_Objects = loadedProperties;
        _propertyTypes = loadedProperties.map((propertyTypeData) {
          PropertyType propertyType = PropertyType.fromJson(propertyTypeData);
          return propertyType;
        }).toList();

        // get cities..
        _cities_Objects =
            jsonResponse['cities'] == null ? [] : jsonResponse['cities'];

        // get aminities..
        _aminities_Objects =
            jsonResponse['aminities'] == null ? [] : jsonResponse['aminities'];

        // get purposes..
        _purposes_Objects =
            jsonResponse['purposes'] == null ? [] : jsonResponse['purposes'];

        // get nearest locations Objects...
        _nearest_locations_Objects = jsonResponse['nearest_locatoins'] == null
            ? []
            : jsonResponse['nearest_locatoins'];

        // get periods Objects..
        _periods_Objects =
            jsonResponse['period'] == null ? [] : jsonResponse['period'];

        if (responseJson.isEmpty &&
            _propertyTypes_Objects.isEmpty &&
            _cities_Objects!.isEmpty &&
            _aminities_Objects!.isEmpty &&
            _purposes_Objects!.isEmpty &&
            _nearest_locations_Objects!.isEmpty &&
            _periods_Objects!.isEmpty) {
          formInitErrorMsg = jsonResponse['messege'];
        } else {
          formInitErrorMsg == null;
        }
        notifyListeners();
      } else {
        formInitErrorMsg = jsonResponse['messege'];
      }
    } catch (e) {
      rethrow;
    }
  }

  void searchByTitle(String? keyWord) {
    if (keyWord!.trim().isEmpty) {
      _filteredProperties = _properties;
      notifyListeners();
      return;
    }
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

  void selectCategory(int? id) {
    // select filtered properties..
    if (id == -1) {
      _filteredProperties = _properties;
      notifyListeners();
      return;
    }
    _filteredProperties = _properties.where((element) {
      return element.property_type!['id'] == id;
    }).toList();
    notifyListeners();
  }

  void clear_filtration_prams() {
    _filtration_prams = {
      "search": "",
      "propertyTypeData": "",
      "country": "",
      "cityId": "",
      "countryStats": "",
      "construction_period": "",
      "floors": "",
      "rooms": "",
      "aminity[]": [],
      "kitchens": "",
      "min_size": "",
      "max_size": "",
      "numberOfBedroom": "",
      "min_price": "",
      "max_price": "",
      "propertyFor": "",
    };
    notifyListeners();
  }

  Future<void> get_properties_with_categories() async {
    try {
      final url = Uri.parse(
        baseUrl + '/api/v1/mobile/properties?page=1',
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

        final List<Property> _loaded_featured_properties = [];
        final List<dynamic> loadedProperties = jsonResponse['data'];

        _properties = loadedProperties.map((property) {
          final Property propertyData = Property.fromJson(
            property,
          );
          _loaded_featured_properties.add(propertyData);
          return propertyData;
        }).toList();
        _featuredProperties = _loaded_featured_properties;

        if (_filteredProperties.isEmpty) {
          selectCategory(selectedCategoryId);
          return;
        }
      } else {
        _properties = [];
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> get_all_properties_with_prams() async {
    try {
      String endPoint = '/api/v1/mobile/properties?page=1';
      filtration_prams.forEach(
        (key, value) {
          if (value != null && value != "") {
            if (value is List && value.isNotEmpty) {
              value.forEach(
                (element) {
                  endPoint += '&$key=$element';
                },
              );
            } else {
              if (value is List) return;
              endPoint += '&' + key.toString() + '=' + value.toString();
            }
          }
        },
      );
      log(endPoint);

      final url = Uri.parse(
        baseUrl + endPoint,
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
        _filteredPropertiesWithPrams = loadedPrprties.map((property) {
          final Property propertyData = Property.fromJson(
            property,
          );
          return propertyData;
        }).toList();
      } else {
        _filteredPropertiesWithPrams = [];
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> get_more_properties_with_prams() async {
    try {
      log("getting more properties");
      if (getting_more_data!) return;
      getting_more_data = true;
      currentPageForFiltration = currentPageForFiltration! + 1;
      String endPoint = '/api/v1/mobile/properties?page=' +
          currentPageForFiltration.toString();
      filtration_prams.forEach(
        (key, value) {
          if (value != null && value != "") {
            if (value is List && value.isNotEmpty) {
              value.forEach(
                (element) {
                  endPoint += '&$key=$element';
                },
              );
            } else {
              if (value is List) return;
              endPoint += '&' + key.toString() + '=' + value.toString();
            }
          }
        },
      );
      log(endPoint);

      final url = Uri.parse(
        baseUrl + endPoint,
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
        if (loadedPrprties.isEmpty) {
          currentPageForFiltration = currentPageForFiltration! - 1;
          return;
        }
        _filteredPropertiesWithPrams.addAll(loadedPrprties.map((property) {
          final Property propertyData = Property.fromJson(
            property,
          );
          return propertyData;
        }).toList());
        getting_more_data = false;
      } else {
        getting_more_data = false;
        _filteredPropertiesWithPrams = [];
      }
      notifyListeners();
    } catch (e) {
      getting_more_data = false;
      rethrow;
    }
  }

  void gettingMoreData(bool getMoreData) {
    getting_more_data = getMoreData;
    notifyListeners();
  }

  Future<void> get_more_properties_with_categories() async {
    try {
      currentPage = currentPage! + 1;
      getting_more_data = true;
      final url = Uri.parse(
        baseUrl + '/api/v1/mobile/properties?page=$currentPage',
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
            if (propertyData.is_featured == 1)
              _featuredProperties.add(propertyData);
            return propertyData;
          }).toList(),
        );

        selectCategory(selectedCategoryId);
      } else {
        getting_more_data = false;
      }
    } catch (e) {
      getting_more_data = false;
      rethrow;
    }
  }

  Future<String?> createProperty(
    Map<String, dynamic> propertyData,
  ) async {
    try {
      final String? token = await AuthProvider().getUserToken();
      if (token != null && token != "") {
        formResponseErrorMsgs = [];
        final url = Uri.parse(
          baseUrl + '/api/v1/mobile/user/properties',
        );

        final String? requestData = convert.jsonEncode(propertyData);
        // Await the http post response.
        final response = await http.post(
          url,
          headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            "Authorization": "bearer " + token,
            "Connection": "keep-alive",
          },
          body: requestData,
        );

        final responseJson = convert.jsonDecode(response.body);
        // log(responseJson.toString());
        if (response.statusCode == 200) {
          formResponseErrorMsgs = [];
          return "posted";
        } else {
          if (responseJson['errors'] != null) {
            Map<String, dynamic>? errors =
                responseJson['errors'] as Map<String, dynamic>;
            formResponseErrorMsgs = [];
            errors.forEach((key, value) {
              formResponseErrorMsgs!.add(value.first);
            });
          }
          return responseJson['message'];
        }
      }
      return "unAuthenticated";
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> sendMessage(
    Map<String, dynamic> data,
    String propertyId,
  ) async {
    try {
      final String? token = await AuthProvider().getUserToken();
      if (token != null && token != "") {
        final url = Uri.parse(
          baseUrl + '/api/v1/mobile/properties/interested/$propertyId',
        );

        final String? requestData = convert.jsonEncode(data);
        // Await the http post response.
        final response = await http.post(
          url,
          headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            "Authorization": "bearer " + token,
            "Connection": "keep-alive",
          },
          body: requestData,
        );

        final responseJson = convert.jsonDecode(response.body);
        if (response.statusCode == 200) {
          log(responseJson.toString());
          return "posted";
        } else {
          return responseJson['message'];
        }
      }
      return "unAuthenticated";
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getInitMessage(
    int propertyId,
  ) async {
    try {
      final url = Uri.parse(
        baseUrl + '/api/v1/mobile/properties/i-interested-msg/$propertyId',
      );

      // Await the http post response.
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "application/json",
          "Connection": "keep-alive",
        },
      );

      final responseJson = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return responseJson['i_interested_msg_ar'];
      } else {
        return responseJson['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
