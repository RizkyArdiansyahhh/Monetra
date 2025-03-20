part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoginUser extends UserEvent {
  final User user;
  const LoginUser({required this.user});

  @override
  List<Object> get props => [user];
}

class LogoutUser extends UserEvent {}

class AddUser extends UserEvent {
  final User newUser;

  const AddUser({required this.newUser});

  @override
  List<Object> get props => [newUser];
}
