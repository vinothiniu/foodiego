class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? token;
  final String? avatar;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.token,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'avatar': avatar,
    };
  }
}