import 'package:flutter_clean_arc/features/authentication/domain/entities/user.dart';

import '../../../../core/utils/typedef.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFuture<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
