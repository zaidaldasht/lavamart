import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String Id;
  final String UserName;
  final String? image;
  final String Email;

  const User({
    required this.Id,
    required this.UserName,
    this.image,
    required this.Email,
  });

  @override
  List<Object> get props => [
    Id,
    UserName,
    Email,
  ];
}