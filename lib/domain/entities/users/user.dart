import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String Id;
  final String UserName;
  final String? image;
  final String Email;
  final String PhoneNumber;


  const User({
    required this.Id,
    required this.UserName,
    this.image,
    required this.Email,
    required this.PhoneNumber,
  });

  @override
  List<Object> get props => [
    Id,
    UserName,
    Email,
  ];
}