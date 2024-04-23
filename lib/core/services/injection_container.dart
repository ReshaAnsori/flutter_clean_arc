import 'package:flutter_clean_arc/features/authentication/data/datasource/remote/authentication_data_source.dart';
import 'package:flutter_clean_arc/features/authentication/data/repository_implementation/authentication_implementation.dart';
import 'package:flutter_clean_arc/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_clean_arc/features/authentication/domain/usecases/create_user.dart';
import 'package:flutter_clean_arc/features/authentication/domain/usecases/get_users.dart';
import 'package:flutter_clean_arc/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// sl = Service Locator
final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory(() => AuthenticationCubit(
          createUser: sl(),
          getUsers: sl(),
        ))
    ..registerLazySingleton(() => GetUsers(sl()))
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationImplementation(sl()))
    ..registerLazySingleton<AuthenticationRemoteSource>(
        () => AuthenticationRemoteSourceImplementation(sl()))
    ..registerLazySingleton(() => http.Client);
}
