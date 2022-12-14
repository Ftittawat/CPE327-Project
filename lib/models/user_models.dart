// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String name;
  String email;
  String? phone;
  String? other;
  UserModel({
    required this.name,
    required this.email,
    this.phone,
    this.other,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? other,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      other: other ?? this.other,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'other': other,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
      other: map['other'] != null ? map['other'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, phone: $phone, other: $other)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.other == other;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ phone.hashCode ^ other.hashCode;
  }
}
