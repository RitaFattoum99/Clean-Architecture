import 'package:clean_architecture/core/error/Failure.dart';
import 'package:clean_architecture/features/Auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository{
  Future<Either<Failure,Unit>> signUp(User user);
  Future<Either<Failure,User>> signIn(User user);
  Future<Either<Failure,Unit>> logout();
}