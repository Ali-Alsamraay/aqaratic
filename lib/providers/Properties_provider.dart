import 'dart:developer';
import 'dart:typed_data';

import 'package:aqaratak/providers/Auth_Provider.dart';
import 'package:aqaratak/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../helper/constants.dart';
import '../models/Property_Field.dart';
import '../models/Property_Type.dart';
import '../models/property.dart';
import 'package:sizer/sizer.dart';

class PropertiesProvider with ChangeNotifier {
  List<Property> _properties = [];
  List<PropertyType> _propertyTypes = [];
  List<Property> _filteredProperties = [];
  
  List<PropertyField> _propertiesFields = [];
  
  List<dynamic> _propertyTypes_Objects = [];
  List<dynamic>? _cities_Objects = [];
  List<dynamic>? _purposes_Objects = [];
  List<dynamic>? _aminities_Objects = [];
  List<dynamic>? _nearest_locatoins_Objects = [];
  List<dynamic>? _periods_Objects = [];
  String? formInitErrorMsg = null;
  List<dynamic>? formResponseErrorMsgs = [];

  List<PropertyType> get propertyTypes => [..._propertyTypes];
  List<Property> get properties => [..._properties];
  List<Property> get filteredProperties => [..._filteredProperties];
  
  List<PropertyField> get propertiesFields => [..._propertiesFields];
  
  List<dynamic> get propertyTypes_Objects => [..._propertyTypes_Objects];
  List<dynamic> get cities_Objects => [..._cities_Objects!];
  List<dynamic> get purposes_Objects => [..._purposes_Objects!];
  List<dynamic> get aminities_Objects => [..._aminities_Objects!];
  List<dynamic> get nearest_locatoins_Objects =>
      [..._nearest_locatoins_Objects!];
  List<dynamic> get periods_Objects => [..._periods_Objects!];

  int? currentPage = 1;
  bool? getting_more_data = false;
  int? selectedCategoryId = -1;
  Property? propertyToBeUploaded = Property();

  final List<Map<String, dynamic>>? property_types_items = [
    {
      "id": -1,
      "title": "الكل",
      "slug": "all",
    },
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

  void cleare_form_data() {
    _aminities_Objects = [];
    _cities_Objects = [];
    _nearest_locatoins_Objects = [];
    _propertiesFields = [];
    _propertyTypes = [];
    _purposes_Objects = [];
    _propertyTypes_Objects = [];
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
        final List<dynamic> loadedPrprties =
            jsonResponse['propertyTypes'] == null
                ? []
                : jsonResponse['propertyTypes'];
        _propertyTypes_Objects = loadedPrprties;
        _propertyTypes = loadedPrprties.map((propertyTypeData) {
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

        // get nearest locatoins Objects...
        _nearest_locatoins_Objects = jsonResponse['nearest_locatoins'] == null
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
            _nearest_locatoins_Objects!.isEmpty &&
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

  void selecteCategory(int? id) {
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

        final List<dynamic> loadedPrprties = jsonResponse['data'];
        // final List<dynamic> loadedPrprtiesTypes =
        //     jsonResponse['data']['property_type'];
        _properties = loadedPrprties.map((property) {
          final Property propertyData = Property.fromJson(
            property,
          );
          return propertyData;
        }).toList();

        // _propertyTypes = loadedPrprtiesTypes.map((propertyType) {
        //   final PropertyType propertyData = PropertyType.fromJson(
        //     propertyType,
        //   );
        //   return propertyData;
        // }).toList();

        if (_filteredProperties.isEmpty) {
          selecteCategory(selectedCategoryId);
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
            return propertyData;
          }).toList(),
        );
        selecteCategory(selectedCategoryId);
      } else {}
    } catch (e) {
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
}
