class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? role;
  bool? isMobileVerified;
  String? phone;
  dynamic image;
  String? token;
  String? commercial_register;
  String? classification_number;
  String? general_authority_no;
  String? authorization_number;
  String? registration_type;

  User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.isMobileVerified,
    this.phone,
    this.password,
    this.token,
    this.image,
    this.commercial_register,
    this.classification_number,
    this.general_authority_no,
    this.authorization_number,
    this.registration_type,
  });

  User.fromJsonWithCustom(Map<String, dynamic> json, {this.token}) {
    id = json['user']['id'];
    name = json['user']['name'];
    email = json['user']['email'];
    password = json['user']['password'];
    role = json['additional_data']['role'];
    isMobileVerified = json['user']['isMobileVerified'];
    phone = json['user']['phone'];
    image = json['user']['image'];
    commercial_register = json['user']['commercial_register'];
    classification_number = json['user']['classification_number'];
    general_authority_no = json['user']['general_authority_no'];
    authorization_number = json['user']['authorization_number'];
    registration_type = json['user']['registration_type'];
  }

  User.fromJson(Map<String, dynamic> json, {this.token}) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    isMobileVerified = json['isMobileVerified'];
    phone = json['phone'];
    image = json['image'];
    commercial_register = json['commercial_register'];
    classification_number = json['classification_number'];
    general_authority_no = json['general_authority_no'];
    authorization_number = json['authorization_number'];
    registration_type = json['registration_type'];
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
    data['commercial_register'] = this.commercial_register;
    data['classification_number'] = this.classification_number;
    data['general_authority_no'] = this.general_authority_no;
    data['authorization_number'] = this.authorization_number;
    data['registration_type'] = this.registration_type;
    return data;
  }
}
