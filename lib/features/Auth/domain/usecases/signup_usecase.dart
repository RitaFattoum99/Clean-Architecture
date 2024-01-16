import 'package:clean_architecture/core/error/Failure.dart';
import 'package:clean_architecture/features/Auth/domain/entities/user.dart';
import 'package:clean_architecture/features/Auth/domain/repositories/user_repositories.dart';
import 'package:dartz/dartz.dart';

class SignUpUseCase{
  final UserRepository userRepository;

  SignUpUseCase({required this.userRepository});

  Future<Either<Failure, Unit>> call(User user) async{
    return await userRepository.signUp(user);
  }
}