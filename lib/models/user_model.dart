class User {
  String id = "";
  String name;
  String surname;
  String username;
  String password;
  String email;
  String phone;
  String photo;
  List<dynamic> languages;
  List<dynamic> location;
  List<dynamic>? peopleliked;
  List<dynamic>? peopledisliked;

  User(
      {this.id = "",
      required this.name,
      required this.surname,
      required this.username,
      required this.password,
      required this.email,
      required this.phone,
      required this.photo,
      required this.languages,
      required this.location,
      this.peopleliked,
      this.peopledisliked});

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
        location: json['location']!,
        peopleliked: json['peopleliked']!,
        peopledisliked: json['peopledisliked']!);
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'name': user.name,
      'surname': user.surname,
      'username': user.username,
      'password': user.password,
      'mail': user.email,
      'phone': user.phone,
      'photo': user.photo,
      'languages': user.languages,
      'location': user.location,
      'peopleliked': user.peopleliked,
      'peopledisliked': user.peopledisliked
    };
  }
}
