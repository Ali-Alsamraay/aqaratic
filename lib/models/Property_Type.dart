class PropertyType {
  int? id;
  String? type;
  String? slug;
  int? status;
  String? iconUrl;
  String? markerIcon;

  PropertyType({
    this.id,
    this.type,
    this.slug,
    this.status,
    this.iconUrl,
    this.markerIcon,
  });

  PropertyType.fromJson(dynamic json) {
    this.id = json['id'];
    this.type = json['type'];
    this.slug = json['slug'];
    this.status = json['status'];
    this.markerIcon = json['marker_icon'];
    this.iconUrl = json['icon'] != null ? json['icon'] : null;
  }

  Map<String, dynamic>? toJson() => {
        "id": this.id,
        "slug": this.slug,
        "type": this.type,
        "status": this.status,
        "icon": this.iconUrl,
        "marker_icon":this.markerIcon,
      };
}
