class User {
  String name;
  String ip;

  static final User _instance = User._internal();
  
  factory User() => _instance;
  
  User._internal();
  
  static User get instance => _instance;
}