import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arc/features/authentication/domain/entities/user.dart';
import 'package:flutter_clean_arc/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_clean_arc/features/authentication/domain/usecases/get_users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repo.mock.dart';

void main() {
  late GetUsers usecase;
  late AuthenticationRepository repository;

  setUp(
    () {
      repository = MockAuthRepo();
      usecase = GetUsers(repository);
    },
  );

  const testResult = [User.empty()];

  test(
    "should call [AuthenticationRepository.getUsers()] and return [List<User>]",
    () async {
      when(() => repository.getUsers())
          .thenAnswer((_) async => const Right(testResult));

      final result = await usecase();

      expect(result, equals(const Right<dynamic, List<User>>(testResult)));
      verify(() => repository.getUsers()).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
