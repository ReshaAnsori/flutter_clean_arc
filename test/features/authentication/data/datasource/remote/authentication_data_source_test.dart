import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_clean_arc/core/errors/exceptions.dart';
import 'package:flutter_clean_arc/core/utils/constants.dart';
import 'package:flutter_clean_arc/features/authentication/data/datasource/remote/authentication_data_source.dart';
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
          Uri.parse("$baseUrl$createUsersEndpoint"),
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
          Uri.parse("$baseUrl$createUsersEndpoint"),
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
}
