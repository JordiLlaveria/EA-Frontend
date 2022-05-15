class Login {
  String? id;
  String email;
  String password;

  Login({required this.email, this.id, required this.password});

  factory Login.fromJson(Map<String, dynamic> json){
    return Login(
      email: json['email']!, id: json['_id'], password: json['password']);
  }

  static Map<String, dynamic> toJson(Login login){
    return{
      'password':login.password,
      'email':login.email,
    };
  }

}