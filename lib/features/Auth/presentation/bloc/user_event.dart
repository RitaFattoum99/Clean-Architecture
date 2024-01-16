part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class SignUpEvent extends UserEvent{
  final User user;

  const SignUpEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class SignInEvent extends UserEvent{
  final User user;

  const SignInEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class LogOutEvent extends UserEvent{
  final User user;

  const LogOutEvent({required this.user});

  @override
  List<Object> get props => [];
}

