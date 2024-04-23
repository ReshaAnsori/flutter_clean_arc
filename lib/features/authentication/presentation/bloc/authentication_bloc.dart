import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_arc/features/authentication/domain/usecases/create_user.dart';
import 'package:flutter_clean_arc/features/authentication/domain/usecases/get_users.dart';

import '../../domain/entities/User.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final CreateUser _createUser;
  final GetUsers _getUsers;

  AuthenticationBloc({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUserHandler);
  }

  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(CreatingUserState());

    final result = await _createUser(
      CreateUserParams(
        createdAt: event.createdAt,
        name: event.name,
        avatar: event.avatar,
      ),
    );

    result.fold(
      (l) => emit(AuthErrorState(l.errorMessage)),
      (_) => emit(UserCreatedState()),
    );
  }

  Future<void> _getUserHandler(
    GetUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(GettingUserState());
    final result = await _getUsers();

    result.fold(
      (l) => emit(AuthErrorState(l.errorMessage)),
      (r) => emit(UserLoadedState(r)),
    );
  }
}
