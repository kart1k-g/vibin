// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

class UserModel {
  final String name;
  final String id;
  final String email;
  final String token;

  UserModel({
    required this.name,
    required this.id,
    required this.email,
    required this.token,
  });

  UserModel copyWith({String? name, String? id, String? email, String? token}) {
    return UserModel(
      name: name ?? this.name,
      id: id ?? this.id,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'email': email,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    log(map.toString());
    return UserModel(
      name: map['name'] ?? '',
      id: map['userId'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, id: $id, email: $email, token: $token)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.id == id &&
        other.email == email &&
        other.token == token;
  }

  @override
  int get hashCode {
    return name.hashCode ^ id.hashCode ^ email.hashCode ^ token.hashCode;
  }
}
