import 'package:flutter_clean_arc/core/usecase/usecase.dart';
import 'package:flutter_clean_arc/core/utils/typedef.dart';
import 'package:flutter_clean_arc/features/authentication/domain/entities/User.dart';
import 'package:flutter_clean_arc/features/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  GetUsers(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
  
}