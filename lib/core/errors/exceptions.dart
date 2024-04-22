import 'package:equatable/equatable.dart';

class APIException extends Equatable implements Exception {
  const APIException({
    required this.statusCode,
    required this.message,
  });

  final int statusCode;
  final String message;

  @override
  List<Object?> get props => [statusCode, message];
}
