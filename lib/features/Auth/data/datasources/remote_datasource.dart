import 'dart:convert';

import 'package:clean_architecture/core/error/exiptions.dart';
import 'package:clean_architecture/features/Auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<Unit> signUp(UserModel userModel);
  Future<UserModel> signIn(UserModel userModel);
  Future<Unit> logOut();
}

const String baseUrlApi = "https://talebadmin.perla-tech.com";

class RemoteDataSourceImplementation implements RemoteDataSource{

  final http.Client client;

  RemoteDataSourceImplementation({required this.client});

  @override
  Future<Unit> signUp(UserModel userModel) async{

    final body ={
      'name': userModel.name,
      'full_name' : userModel.fullName,
      'phone' : userModel.phone,
      'password' : userModel.password
    };

    final response = await client.post(Uri.parse("$baseUrlApi/test/register/"),
        headers: {"Content-Type": "application/json"},
        body: body,
    );

    if(response.statusCode == 200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<UserModel> signIn(UserModel userModel) async{
    final body ={
      'full_name' : userModel.fullName,
      'password' : userModel.password
    };
    
    final response = await client.post(Uri.parse("$baseUrlApi/test/log_in/"),
        headers: {"Content-Type": "application/json"},
        body: body);


    if(response.statusCode == 200){
      final userJsonDecoded = json.decode(response.body);
      final UserModel userModel = UserModel.fromJson(userJsonDecoded);
      // final UserModel userModel = userJsonDecoded.map<UserModel>((jsonUserModel)=>UserModel.fromJson(jsonUserModel));
      return userModel;
    }else{
      throw ServerException();
    }}

  @override
  Future<Unit> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }
}