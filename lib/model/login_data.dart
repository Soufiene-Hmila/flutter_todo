import 'package:equatable/equatable.dart';

class LoginData extends Equatable {

  final String? username;
  final String? password;

  const LoginData({
      this.username,
      this.password,
  });

  factory LoginData.fromJson(dynamic json) {
    return LoginData(
      username: json['username'],
      password: json['password'],
    );
  }


  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };

  @override
  List<Object?> get props => [
    username,
    password,
  ];

}