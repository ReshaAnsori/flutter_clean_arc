import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arc/core/errors/exceptions.dart';
import 'package:flutter_clean_arc/core/errors/failure.dart';
import 'package:flutter_clean_arc/features/authentication/data/datasource/remote/authentication_data_source.dart';
import 'package:flutter_clean_arc/features/authentication/data/models/user_model.dart';
import 'package:flutter_clean_arc/features/authentication/data/repository_implementation/authentication_implementation.dart';
import 'package:flutter_clean_arc/features/authentication/domain/entities/User.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRemoteSource extends Mock
    implements AuthenticationRemoteSource {}

void main() {
  late AuthenticationRemoteSource remoteSource;
  late AuthenticationImplementation repository;
  const testException = APIException(statusCode: 500, message: "Someting went wrong");

  setUp(() {
    remoteSource = MockAuthenticationRemoteSource();
    repository = AuthenticationImplementation(remoteSource);
  });

  group("createUser", () {
    const createdAt = "something.createdAt";
    const name = "something.name";
    const avatar = "something.avatar";

    test("should be bla bla bla...", () async {
      when(
        () => remoteSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar')),
      ).thenAnswer((_) async => Future.value()); // return jika void

      final result = await repository.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      expect(result, equals(const Right(null)));
      verify(
        () => remoteSource.createUser(
            createdAt: createdAt, name: name, avatar: avatar),
      ).called(1);
      verifyNoMoreInteractions(remoteSource);
    });

    test("should throw [APIException] when call to server unsuccessful",
        () async {
      when(
        () => remoteSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar')),
      ).thenThrow(testException);

      final result = await repository.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      expect(
          result,
          equals(Left(APIFailure(
            statusCode: testException.statusCode,
            message: testException.message,
          ))));

      verify(() => remoteSource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          )).called(1);

      verifyNoMoreInteractions(remoteSource);
    });
  });

  group("getUsers", () {
    const testUsers = [UserModel.empty()];

    test(
        "should be call [AuthenticationImplementation.getUsers] and "
        "return [List<UserModel>]", () async {
      when(() => remoteSource.getUsers()).thenAnswer(
        (_) async => testUsers,
      );

      final result = await repository.getUsers();
      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => remoteSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteSource);
    });

    test("should throw [APIException] when call to server unsuccessful",
        () async {
      when(
        () => remoteSource.getUsers(),
      ).thenThrow(testException);

      final result = await repository.getUsers();

      expect(
          result,
          equals(Left(APIFailure(
            statusCode: testException.statusCode,
            message: testException.message,
          ))));

      verify(() => remoteSource.getUsers()).called(1);

      verifyNoMoreInteractions(remoteSource);
    });
  });
}
