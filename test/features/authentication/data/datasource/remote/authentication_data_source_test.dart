import 'dart:convert';

import 'package:flutter_clean_arc/core/errors/exceptions.dart';
import 'package:flutter_clean_arc/core/utils/constants.dart';
import 'package:flutter_clean_arc/features/authentication/data/datasource/remote/authentication_data_source.dart';
import 'package:flutter_clean_arc/features/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockAuthenticationRemoteSourceImpl extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteSourceImplementation datasource;

  setUp(() {
    client = MockAuthenticationRemoteSourceImpl();
    datasource = AuthenticationRemoteSourceImplementation(client);
    registerFallbackValue(Uri());
  });

  group("crateUser", () {
    test("should complete successfully when the status code is 200 or 201",
        () async {
      when(
        () => client.post(any(), body: any(named: "body")),
      ).thenAnswer(
          (_) async => http.Response("Created user successfully", 200));

      final methodCall = datasource.createUser;

      expect(
          methodCall(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
          completes);

      verify(
        () => client.post(
          Uri.https(baseUrl, createUsersEndpoint),
          body: jsonEncode(
            {
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            },
          ),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test("should throw [APIException] when the status code is not 200 or 201",
        () async {
      when(
        () => client.post(any(), body: any(named: "body")),
      ).thenAnswer((_) async => http.Response("Unauthorize", 401));

      final methodCall = datasource.createUser;

      expect(
        () => methodCall(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        ),
        throwsA(const APIException(
          statusCode: 401,
          message: "Unauthorize",
        )),
      );

      verify(
        () => client.post(
          Uri.https(baseUrl, createUsersEndpoint),
          body: jsonEncode(
            {
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            },
          ),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group("getUser", () {
    const testUsers = [UserModel.empty()];
    test("should be return [List<User>] when status code is 200", () async {
      when(
        () => client.get(any()),
      ).thenAnswer(
        (_) async => http.Response(jsonEncode([testUsers.first.toMap()]), 200),
      );

      final result = await datasource.getUsers();
      expect(result, equals(testUsers));

      verify(
        () => client.get(Uri.https(baseUrl, getUsersEndpoint)),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test("should be throw [APIException] when status code is not 200",
        () async {
      when(
        () => client.get(any()),
      ).thenAnswer(
        (_) async => http.Response("Not found", 500),
      );

      final methodCall = datasource.getUsers;

      expect(
        () => methodCall(),
        throwsA(const APIException(
          statusCode: 500,
          message: "Not found",
        )),
      );

      verify(
        () => client.get(
          Uri.https(baseUrl, getUsersEndpoint),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
