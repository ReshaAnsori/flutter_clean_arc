import 'dart:convert';
import 'dart:io';

import 'package:flutter_clean_arc/features/authentication/data/models/user_model.dart';
import 'package:flutter_clean_arc/features/authentication/domain/entities/User.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testModel = UserModel.empty();
  
  test("should be a subclass of [User] entity", () {
    expect(testModel, isA<User>());
  });

  final testJson = fixture('user.json');
  final testMap = jsonDecode(testJson) as Map<String, dynamic>;

  group("fromMap", () { 
    test("should return a [UserModel] with the valid data", () {
      final result = UserModel.fromMap(testMap);
      expect(result, equals(testModel));
    });
  });

  group("fromJson", () { 
    test("should return a [UserModel] with the valid data", () {
      final result = UserModel.fromJson(testJson);
      expect(result, equals(testModel));
    });
  });

  group("toMap", () { 
    test("should return a [Map] with the valid data", () {
      final result = testModel.toMap();
      expect(result, equals(testMap));
    });
  });

  group("toJson", () { 
    test("should return a [Json] with the valid data", () {
      final result = testModel.toJson();
      expect(result, equals(testJson));
    });
  });

  group("copyWith", () { 
    test("should return a [UserModel] with the defferent data", () {
      final result = testModel.copyWith(name: "Burhanudin");
      // print(result);
      expect(result.name, equals("Burhanudin"));
    });
  });

}
