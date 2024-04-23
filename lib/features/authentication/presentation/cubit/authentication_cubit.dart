import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/User.dart';
import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/get_users.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final CreateUser _createUser;
  final GetUsers _getUsers;

  AuthenticationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthenticationInitial());

  Future<void> createUserHandler(
    String createdAt,
    String name,
    String avatar,
  ) async {
    emit(CreatingUserState());

    final result = await _createUser(
      CreateUserParams(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      ),
    );

    result.fold(
      (l) => emit(AuthErrorState(l.errorMessage)),
      (_) => emit(UserCreatedState()),
    );
  }

  Future<void> getUserHandler() async {
    emit(GettingUserState());
    final result = await _getUsers();

    result.fold(
      (l) => emit(AuthErrorState(l.errorMessage)),
      (r) => emit(UserLoadedState(r)),
    );
  }
}
