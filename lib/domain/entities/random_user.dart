class User {
  User({
    this.id,
    required this.email,
    required this.password,
  });

  int? id;
  final String email;
  final String password;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }
}
