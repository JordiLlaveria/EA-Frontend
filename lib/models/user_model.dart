import 'dart:html';

class UserModel {
  String? id;
  String name;
  String? surname;
  String? username;
  String? password;
  String? email;
  String? phone;
  List<String>? languages;
  List<String>? location;

  UserModel({this.id, required this.name, this.surname, this.username, this.password, this.email, this.phone, this.languages, this.location});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['_id'], name: json['name'], surname: json['surname'], password: json['password'], email: json['email'], phone: json['phone'], languages: json['languages']!, location: json['location']!);
  }

  static Map<String, dynamic> toJson(UserModel user) {
    return {
      'name': user.name,
      'surname': user.surname,
      'username': user.username,
      'password': user.password,
      'email': user.email,
      'phone': user.phone,
      'languages': user.languages,
      'location': user.location,
    };
  }
}
