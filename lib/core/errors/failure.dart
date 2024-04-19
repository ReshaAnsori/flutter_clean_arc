import 'package:equatable/equatable.dart';
import 'package:flutter_clean_arc/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class APIFailure extends Failure {
  const APIFailure({
    required super.message,
    required super.statusCode,
  });

  APIFailure.fromException(APIException ex)
      : this(statusCode: ex.statusCode, message: ex.message);
}
