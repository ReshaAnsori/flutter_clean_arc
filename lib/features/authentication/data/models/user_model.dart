import 'dart:convert';

import 'package:flutter_clean_arc/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.avatar,
  });

  const UserModel.empty()
      : this(
          createdAt: "2024-04-18T07:02:56.729Z",
          name: "Floyd Mills",
          avatar:
              "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/580.jpg",
          id: "1",
        );

  User copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'name': name,
      'avatar': avatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      createdAt: map['createdAt'] ?? '',
      name: map['name'] ?? '',
      avatar: map['avatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, createdAt: $createdAt, name: $name, avatar: $avatar)';
  }
}
