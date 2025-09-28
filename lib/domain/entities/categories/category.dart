import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String CategoryId;
  final String CategoryName;
  final String Description;
  final String Categoryimage;


  const Category({
    required this.CategoryId,
    required this.CategoryName,
    required this.Description,
    required this.Categoryimage,

  });

  @override
  List<Object?> get props => [CategoryId];
}
