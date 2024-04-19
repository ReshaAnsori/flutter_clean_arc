import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arc/core/errors/exceptions.dart';
import 'package:flutter_clean_arc/core/errors/failure.dart';
import 'package:flutter_clean_arc/core/utils/typedef.dart';
import 'package:flutter_clean_arc/features/authentication/data/datasource/remote/authentication_data_source.dart';
import 'package:flutter_clean_arc/features/authentication/data/models/user_model.dart';
import 'package:flutter_clean_arc/features/authentication/domain/entities/user.dart';
import 'package:flutter_clean_arc/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationImplementation implements AuthenticationRepository {
  const AuthenticationImplementation(this._dataSource);

  final AuthenticationRemoteSource _dataSource;

  @override
  VoidFuture createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      await _dataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _dataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
