class User {
  int id;
  String email;
  String? firstname;
  String? lastname;
  String? picUrl;

  User({
    required this.id,
    required this.email,
    this.firstname,
    this.lastname,
    this.picUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      picUrl: json['picUrl']
    );
  }

  String getDisplayName() {
    return (firstname?.isNotEmpty == true && lastname?.isNotEmpty == true) ? '$firstname $lastname' : email ?? 'Unknown user';
  }
}