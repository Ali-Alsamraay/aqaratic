class PropertyCategory {
  int? id;
  String? type;
  String? slug;
  int? status;

  PropertyCategory({this.id, this.type, this.slug, this.status});

   PropertyCategory.fromJson(dynamic json) {
    this.id = json['id'];
    this.type = json['type'];
    this.slug = json['slug'];
    this.status = json['status'];
   }
}
