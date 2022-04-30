part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  const AuthSuccess(this.user);

  final UserModel user;

  @override
  List<Object> get props => [user];
}

class AuthFailed extends AuthState {
  const AuthFailed(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
