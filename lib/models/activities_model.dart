import 'package:frontend/models/user_model.dart';

class Activity {
  String id;
  String name;
  String description;
  dynamic organizer;
  String language;
  List<dynamic> users;
  List<dynamic> location;
  String date;
  //List<dynamic>? ratings;

  Activity({
    required this.id,
    required this.name,
    required this.description,
    required this.language,
    required this.organizer,
    required this.users,
    required this.location,
    //this.ratings,
    required this.date,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        language: json['language'],
        organizer: json['organizer'],
        users: json['users'],
        location: json['location'],
        //ratings: json['ratings'],
        date: json['date']);
  }

  static Map<String, dynamic> toJson(Activity act) {
    return {
      'name': act.name,
      'description': act.description,
      'language': act.language,
      'organizer': act.organizer,
      'users': act.users,
      'location': act.location,
      //'ratings': act.ratings,
      'date': act.date
    };
  }
}
