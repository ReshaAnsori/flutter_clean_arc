// Unit Test file for create_user.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arc/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_clean_arc/features/authentication/domain/usecases/create_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test("Should call [AuthenticationRepository.createUser]", () async {
    when(
      () => repository.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      ),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(params);

    expect(result, const Right<dynamic, void>(null));

    verify(
      () => repository.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      ),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
