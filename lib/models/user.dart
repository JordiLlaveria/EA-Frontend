class User {
  String? id;
  String name;
  String surname;
  String username;
  String password;
  String email;
  String phone;
  List<dynamic> languages;
  List<dynamic> location;

  User(
    {this.id, required this.name, required this.surname, required this.username,
    required this.password, required this.email, required this.phone,
    required this.languages, required this.location});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'], name: json['name'], surname: json['surname'],
        username: json['username'], password: json['password'], email: json['mail'],
        phone: json['phone'], languages: json['languages']!, location: json['location']!);
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'name': user.name,
      'surname': user.surname,
      'username': user.username,
      'password': user.password,
      'mail': user.email,
      'phone': user.phone,
      'languages': user.languages,
      'location': user.location,
    };
  }
}
