import 'dart:convert';
import 'package:frontend/models/activities_model.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class ActivityService {
  static const apiURL =
      String.fromEnvironment('API_URL', defaultValue: 'http://localhost:3000');
  static var baseURL = apiURL + "/api/activities";

  static Future<List<Activity>> getActivities() async {
    var res = await http.get(Uri.parse(baseURL));
    List<Activity> allActivities = [];
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);

      decoded.forEach((act) => allActivities.add(Activity.fromJson(act)));
      return allActivities;
    }
    return [];
  }

  static Future<Activity> getActivity(String activityName) async {
    var res = await http.get(Uri.parse(baseURL + '/' + activityName));
    var decoded = jsonDecode(res.body);
    return Activity.fromJson(decoded);
  }

  static Future addActivity(String name, String description, String organizerId,
      String language, List<String> location) async {
    var res = await http.post(Uri.parse(baseURL + '/'),
        headers: {'content-type': 'application/json'},
        body: json.encode({
          "name": name,
          "description": description,
          "language": language,
          "organizer": organizerId,
          "location": location,
        }));

    print("New activity request has already been done");

    if (res.statusCode != 200) {
      print("Error");
      return Activity.fromJson(json.decode(res.body));
    }
  }
  static Future<List<Activity>> getActivitiesByDistance(
      String distance, String id) async {
    var res =
        await http.get(Uri.parse(baseURL + '/' + id + '/distance/' + distance));
    List<Activity> allActivities = [];
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      decoded.forEach((activity) => allActivities.add(Activity.fromJson(activity)));
      print("Activities by distance get correct");
      return allActivities;
    }
    return [];
  }
}
