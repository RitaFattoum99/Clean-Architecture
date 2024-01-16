import 'package:equatable/equatable.dart';

class User extends Equatable{
  final int id;
  final String name;
  final String fullName;
  final String password;
  final String phone;
  final String timeStamp;

  User({required this.id,
        required this.name,
        required this.fullName,
        required this.password,
        required this.phone,
        required this.timeStamp});

  @override
  List<Object?> get props => [id, name, fullName, password, phone, timeStamp];

}