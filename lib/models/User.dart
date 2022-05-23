class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? role;
  bool? isMobileVerified;
  String? phone;
  dynamic image;
  

  User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.isMobileVerified,
    this.phone,
    this.password,
  });

  User.fromJsonWithCustom(Map<String, dynamic> json) {
    id = json['user']['id'];
    name = json['user']['name'];
    email = json['user']['email'];
    password = json['user']['password'];
    role = json['additional_data']['role'];
    isMobileVerified = json['user']['isMobileVerified'];
    phone = json['user']['phone'];
    image = json['user']['image'];
  }

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    isMobileVerified = json['isMobileVerified'];
    phone = json['phone'];
    image = json['image'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    data['isMobileVerified'] = this.isMobileVerified;
    data['phone'] = this.phone;
    data['image'] = this.image;
    return data;
  }
}
