import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arc/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef VoidFuture = ResultFuture<void>;
typedef DataMap = Map<String, dynamic>;

