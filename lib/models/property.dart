import 'package:flutter/foundation.dart';

class Property with ChangeNotifier {
  int? id;
  String? address;
  int? user_type;
  int? admin_id;
  int? user_id;
  String? title;
  double? price;
  int? property_type_id;
  int? listing_package_id;
  int? city_id;
  int? property_purpose_id;
  String? slug;
  int? views;
  String? phone;
  String? email;
  String? description;
  String? file;
  String? thumbnail_image;
  String? banner_image;
  int? number_of_unit;
  int? number_of_room;
  int? number_of_bedroom;
  int? number_of_bathroom;
  int? number_of_floor;
  int? number_of_kitchen;
  int? number_of_parking;
  double? area;
  String? google_map_embed_code;
  String? period;
  String? video_link;
  int? is_featured;
  int? verified;
  int? top_property;
  int? urgent_property;
  int? status;
  List<dynamic>? images;
  List<String>? images_urls;
  double? latitude;
  double? longitude;
  String? authorization_num_of_GA;

  Map? property_type;

  Property({
    this.id,
    this.address,
    this.user_type,
    this.admin_id,
    this.user_id,
    this.title,
    this.price,
    this.property_type_id,
    this.listing_package_id,
    this.city_id,
    this.property_purpose_id,
    this.slug,
    this.views,
    this.phone,
    this.email,
    this.description,
    this.file,
    this.thumbnail_image,
    this.banner_image,
    this.number_of_unit,
    this.number_of_room,
    this.number_of_bedroom,
    this.number_of_bathroom,
    this.number_of_floor,
    this.number_of_kitchen,
    this.number_of_parking,
    this.area,
    this.google_map_embed_code,
    this.period,
    this.video_link,
    this.is_featured,
    this.verified,
    this.top_property,
    this.urgent_property,
    this.status,
    this.images,
    this.property_type,
    this.images_urls,
    this.latitude,
    this.longitude,
    this.authorization_num_of_GA,
  });

  Property.fromJson(
    dynamic json,
  ) {
    this.id = json['id'];
    this.address = json['address'];
    this.user_type = json['user_type'];
    this.admin_id = json['admin_id'];
    this.user_id = json['user_id'];
    this.title = json['title'];
    this.price = double.parse(json['price'].toString());
    this.property_type_id = json['property_type_id'];
    this.listing_package_id = json['listing_package_id'];
    this.city_id = json['city_id'];
    this.property_purpose_id = json['property_purpose_id'];
    this.slug = json['slug'];
    this.views = json['views'];
    this.phone = json['phone'];
    this.email = json['email'];
    this.description = json['description'];
    this.file = json['file'];
    this.thumbnail_image = json['thumbnail_image'];
    this.banner_image = json['banner_image'];
    this.number_of_unit = json['number_of_unit'];
    this.number_of_room = json['number_of_room'];
    this.number_of_bedroom = json['number_of_bedroom'];
    this.number_of_bathroom = json['number_of_bathroom'];
    this.number_of_floor = json['number_of_floor'];
    this.number_of_kitchen = json['number_of_kitchen'];
    this.number_of_parking = json['number_of_parking'];
    this.area = double.parse(json['area'].toString());
    this.google_map_embed_code = json['google_map_embed_code'];
    this.period = json['period'];
    this.video_link = json['video_link'];
    this.is_featured = json['is_featured'];
    this.verified = json['verified'];
    this.top_property = json['top_property'];
    this.urgent_property = json['urgent_property'];
    this.status = json['status'];
    this.images = json['property_images'];
    this.property_type = json['property_type'];
    this.images_urls = images == null
        ? []
        : images!.map((item) => item['image'].toString()).toList();

    // if the below values are null, the location will be at ryadh.
    this.latitude = json['latitude'] == null
        ? 24.7136
        : double.parse(
            json['latitude'].toString(),
          );
    this.longitude = json['longitude'] == null
        ? 46.6753
        : double.parse(
            json['longitude'].toString(),
          );
    this.authorization_num_of_GA  = json['authorization_num_of_GA'];
  }
}
