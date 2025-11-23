import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/constants/api.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../domain/usecases/users/sign_in_usecase.dart';
import '../../../domain/usecases/users/sign_up_usecase.dart';
import '../../models/user/authentication_response_model.dart';


abstract class UserRemoteDataSource {
  Future<AuthenticationResponseModel> signIn(SignInParams params);
  Future<AuthenticationResponseModel> signUp(SignUpParams params);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthenticationResponseModel> signUp(SignUpParams params) async {
    final response =
    await client.post(Uri.parse('$baseUrl/lavamart/Account/signUp'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'UserName': params.FullName,
          'Email': params.email,
          'Password': params.password,
          'PhoneNumber':params.PhoneNumber,
        }));
    if (response.statusCode == 201) {
      return authenticationResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }


  @override
  Future<AuthenticationResponseModel> signIn(SignInParams params) async {
    final response =
    await client.post(Uri.parse('$baseUrl/lavamart/Account/signIn'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'UserName': params.username,
          'Password': params.password,
        }));
    if (response.statusCode == 200) {
      return authenticationResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }


}