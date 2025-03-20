part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}

final class UserAdded extends UserState {
  final User newUser;

  const UserAdded(this.newUser);

  @override
  List<Object> get props => [newUser];
}

final class UserAuthenticated extends UserState {
  final String? uid;
  final String? email;
  final String? username;

  const UserAuthenticated({this.uid, this.email, this.username});
}

final class UserUnauthenticated extends UserState {}
