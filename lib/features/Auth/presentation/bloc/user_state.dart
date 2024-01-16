part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class LoadingState extends UserState{}

class SuccessState extends UserState{
  final String message;

  const  SuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class ErrorState extends UserState{
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}