part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

class CreatingUserState extends AuthenticationState {}
class GettingUserState extends AuthenticationState {}
class UserCreatedState extends AuthenticationState {}
class AuthErrorState extends AuthenticationState {
  const AuthErrorState(this.message);

  final String message;

  @override
  List<Object> get props => [message];  
}
class UserLoadedState extends AuthenticationState {
  const UserLoadedState(this.users);

  final List<User> users;

  @override
  List<Object> get props => users.map((e) => e.id).toList();
}

