import 'package:clean_architecture/core/error/Failure.dart';
import 'package:clean_architecture/core/error/exiptions.dart';
import 'package:clean_architecture/features/Auth/data/models/user_model.dart';
import 'package:clean_architecture/features/Auth/domain/entities/user.dart';
import 'package:clean_architecture/features/Auth/domain/repositories/user_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/network_information.dart';
import '../datasources/remote_datasource.dart';

typedef Future<Unit> SignUpOrSignInOrLogOut();

class UserRepositoryImplementation extends UserRepository{

  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  UserRepositoryImplementation({required this.networkInfo,required this.remoteDataSource});

  @override
  Future<Either<Failure, Unit>> signUp(User user) async{
    final UserModel userModel = UserModel(id: user.id, name: user.name, fullName: user.fullName, password: user.password, phone: user.phone, timeStamp: user.timeStamp);

    return await _signUpLogOut((){
      return remoteDataSource.signUp(userModel);
    });
  }


  @override
  Future<Either<Failure, User>> signIn(User user) async{
    final UserModel userModel = UserModel(id: user.id, name: user.name, fullName: user.fullName, password: user.password, phone: user.phone, timeStamp: user.timeStamp);
    if(await networkInfo.isConnected){
      try{
        final UserModel user =  await remoteDataSource.signIn(userModel);
        return Right(user);
      } on ServerException{
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async{

    return await _signUpLogOut((){
      return remoteDataSource.logOut();
    });
  }

  Future<Either<Failure, Unit>> _signUpLogOut(SignUpOrSignInOrLogOut signUpOrSignInOrLogOut) async{
    if(await networkInfo.isConnected){
      try{
        await signUpOrSignInOrLogOut();
        return Right(unit);
      } on ServerException{
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

}