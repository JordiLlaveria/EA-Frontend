class Location {
  String type;
  List<dynamic> coordinates;

  Location(
      {required this.type,
      required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        type: json['type'],
        coordinates: json['coordinates']!);
  }

  static Map<String, dynamic> toJson(Location location) {
    return {
      'type': location.type,
      'coordinates': location.coordinates
    };
  }
}
