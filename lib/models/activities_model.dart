import 'package:frontend/models/user_model.dart';
import 'package:frontend/models/location_model.dart';

class Activity {
  String? id;
  String name;
  String description;
  dynamic organizer;
  String language;
  List<dynamic>? users;
  Location location;
  String date;
  //List<dynamic>? ratings;
  bool accessibility;

  Activity(
      {this.id,
      required this.name,
      required this.description,
      required this.language,
      required this.organizer,
      this.users,
      required this.location,
      //this.ratings,
      required this.date,
      required this.accessibility});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        language: json['language'],
        organizer: json['organizer'],
        users: json['users'],
        location: Location.fromJson(json['location']),
        date: json['date'],
        accessibility: json['accessibility']);
    //ratings: json['ratings'],
  }

  static Map<String, dynamic> toJson(Activity act) {
    Map location = Location.toJson(act.location);
    return {
      'name': act.name,
      'description': act.description,
      'language': act.language,
      'organizer': act.organizer,
      'users': act.users,
      'location': location,
      //'ratings': act.ratings,
      'date': act.date,
      'accessibility': act.accessibility
    };
  }
}
