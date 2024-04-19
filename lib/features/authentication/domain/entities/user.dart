import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const User.empty()
      : this(
          id: '0',
          name: "default.name",
          createdAt: "default.createdAt",
          avatar: "default.avatar",
        );

  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object> get props => [id, createdAt, name, avatar];
}
