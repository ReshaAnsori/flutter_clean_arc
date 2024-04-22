import 'dart:convert';

import 'package:flutter_clean_arc/core/errors/exceptions.dart';
import 'package:flutter_clean_arc/core/errors/failure.dart';
import 'package:flutter_clean_arc/core/utils/constants.dart';
import 'package:flutter_clean_arc/features/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>>
      getUsers(); // pake userModel karena ada method-method nya
}

class AuthenticationRemoteSourceImplementation
    extends AuthenticationRemoteSource {
  AuthenticationRemoteSourceImplementation(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse("$baseUrl$createUsersEndpoint"),
        body: jsonEncode(
          {
            'createdAt': createdAt,
            'name': name,
            'avatar': avatar,
          },
        ),
      );

      if (![200, 201].contains(response.statusCode)) {
        throw APIException(
          statusCode: response.statusCode,
          message: response.body,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(statusCode: 505, message: e.toString());
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
