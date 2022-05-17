class User {
  late final String name;
  late final String age;
  late final String password;

  User({
    required this.name, 
    required this.age, 
    required this.password});

  factory User.fromJSON(dynamic json){
    return User(
      name: json['name'],
      age: json['age'], 
      password: json['password']
      );
  }

   static Map<String, dynamic> toJson(User user) {
    return {
      'name': user.name,
      'age': user.age,
      'password': user.password,
    };
  }
}