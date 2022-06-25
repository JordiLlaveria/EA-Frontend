import 'package:frontend/models/location_model.dart';
import 'package:geojson/geojson.dart';
import 'package:geopoint/geopoint.dart';

class User {
  String? id;
  String name;
  String surname;
  String username;
  String password;
  String email;
  String phone;
  String photo;
  List<dynamic> languages;
  Location location;
  bool nolike;
  bool like;
  bool fromGoogle;

  User(
      {this.id,
      required this.name,
      required this.surname,
      required this.username,
      required this.password,
      required this.email,
      required this.phone,
      required this.photo,
      required this.languages,
      required this.location,
      required this.fromGoogle,
      this.nolike = false,
      this.like = false});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        name: json['name'],
        surname: json['surname'],
        username: json['username'],
        password: json['password'],
        email: json['mail'],
        phone: json['phone'],
        photo: json['photo'],
        languages: json['languages']!,
        location: Location.fromJson(json['location'])),
        fromGoogle: json['fromGoogle']);
  }

  static Map<String, dynamic> toJson(User user) {
    Map location = Location.toJson(user.location);
    return {
      'name': user.name,
      'surname': user.surname,
      'username': user.username,
      'password': user.password,
      'mail': user.email,
      'phone': user.phone,
      'photo': user.photo,
      'languages': user.languages,
      'location': location,
      'fromGoogle': user.fromGoogle
    };
  }
}
