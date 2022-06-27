import 'package:frontend/models/user_model.dart';

class ShuffleViewModel{
  final User _user;
  ShuffleViewModel({required User user}) : _user = user;
  
  String? get id => _user.id;
  String get name => _user.name;
  String get email => _user.email;
  
}