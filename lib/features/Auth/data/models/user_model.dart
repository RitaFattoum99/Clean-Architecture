import 'package:clean_architecture/features/Auth/domain/entities/user.dart';

class UserModel extends User{

  UserModel({
    required super.id,
    required super.name,
    required super.fullName,
    required super.password,
    required super.phone,
    required super.timeStamp});

  // From json to model
  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
        id: json['id'],
        name: json['name'],
        fullName: json['fullName'],
        password: json['password'],
        phone: json['phone'],
        timeStamp: json['timeStamp']
    );
  }

  // From model to json
  Map<String, dynamic> tojson(){
    return {
      'id': id,
      'name' : name,
      'fullName': fullName,
      'password': password,
      'phone': phone,
      'timeStamp': timeStamp
    };
  }
}