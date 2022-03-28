///
/// {
///   "id": "1",
///   "name": "Pixbit Solutions",
///   "email": "contact@pixbitsolutions.com",
///   "phone": "1234567889",
///   "password": "12345"
/// }
class UserModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.token,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    email = json['email']?.toString();
    phone = json['phone']?.toString();
    token = json['password']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = token;
    return data;
  }
}
