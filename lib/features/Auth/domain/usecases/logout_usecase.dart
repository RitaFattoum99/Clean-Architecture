import 'package:clean_architecture/core/error/Failure.dart';
import 'package:clean_architecture/features/Auth/domain/repositories/user_repositories.dart';
import 'package:dartz/dartz.dart';

class LogOutUseCase {
  final UserRepository userRepository;

  LogOutUseCase({required this.userRepository});

  Future<Either<Failure, Unit>> call() async{
    return await userRepository.logout();
  }
}