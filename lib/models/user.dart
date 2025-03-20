class User {
  final String? uid;
  final String email;
  final String? password;
  final String? username;

  User({this.uid, required this.email, this.password, this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json["uid"],
      email: json["email"],
      username: json["username"],
    );
  }
}
