import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arc/core/errors/exceptions.dart';
import 'package:flutter_clean_arc/core/errors/failure.dart';
import 'package:flutter_clean_arc/features/authentication/domain/entities/User.dart';
import 'package:flutter_clean_arc/features/authentication/domain/usecases/create_user.dart';
import 'package:flutter_clean_arc/features/authentication/domain/usecases/get_users.dart';
import 'package:flutter_clean_arc/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUsers extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit authenticationCubit;

  const testUserParams = CreateUserParams.empty();
  const testAPIFailure =
      APIFailure(message: "something went wrong", statusCode: 400);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUsers();
    authenticationCubit =
        AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(testUserParams);
  });

  tearDown(() => authenticationCubit.close());

  test("Initial state shoud be [AuthenticationInitial]", () async {
    expect(authenticationCubit.state, AuthenticationInitial());
  });

  group("createUser", () {
    blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [CreatingUserState, UserCreatedState] when successfully call [AuthenticationCubit.createUserHandler]',
        build: () {
          when(() => createUser(any())).thenAnswer(
            (_) async => const Right(null),
          );
          return authenticationCubit;
        },
        act: (cubit) => cubit.createUserHandler(
              testUserParams.createdAt,
              testUserParams.name,
              testUserParams.avatar,
            ),
        expect: () => [
              CreatingUserState(),
              UserCreatedState(),
            ],
        verify: (_) {
          verify(() => createUser(testUserParams)).called(1);
          verifyNoMoreInteractions(createUser);
        });

    blocTest<AuthenticationCubit, AuthenticationState>(
      "should emit [CreatingUserState, AuthErrorState] when unsuccessfully call [AuthenticationCubit.createUserHandler]",
      build: () {
        when(() => createUser(any())).thenAnswer(
          (_) async => const Left(testAPIFailure),
        );

        return authenticationCubit;
      },
      act: (bloc) => bloc.createUserHandler(
        testUserParams.createdAt,
        testUserParams.name,
        testUserParams.avatar,
      ),
      expect: () =>
          [CreatingUserState(), AuthErrorState(testAPIFailure.errorMessage)],
      verify: (_) {
        verify(() => createUser(testUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
  });

  group("getUsers", () {
    const testUsers = [User.empty()];
    blocTest<AuthenticationCubit, AuthenticationState>(
      "should emit [GettingUserState, UserLoadedState] when successfully call [AuthenticationCubit.getUserHandler]",
      build: () {
        when(
          () => getUsers(),
        ).thenAnswer((_) async => const Right(testUsers));
        return authenticationCubit;
      },
      act: (bloc) => bloc.getUserHandler(),
      expect: () => [GettingUserState(), const UserLoadedState(testUsers)],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      "should emit [GettingUserState, AuthErrorState] when unsuccessfully call [AuthenticationCubit.getUserHandler]",
      build: () {
        when(
          () => getUsers(),
        ).thenAnswer((_) async => const Left(testAPIFailure));
        return authenticationCubit;
      },
      act: (bloc) => bloc.getUserHandler(),
      expect: () => [
        GettingUserState(),
        AuthErrorState(testAPIFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
  });
}
