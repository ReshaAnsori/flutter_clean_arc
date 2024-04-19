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
  }) async {}

  @override
  Future<List<UserModel>> getUsers() async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
