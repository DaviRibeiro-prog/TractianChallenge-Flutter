import 'package:dio/dio.dart';
import 'package:tractian_challenge/models/user_model.dart';
import 'package:tractian_challenge/repos/i_main_repository.dart';

import '../../../repos/api_url.dart';

class MainRepository extends IMainRepository {
  final Dio _dio = Dio();

  @override
  Future<List<User>> getUsers() async {
    var response = await _dio.get('${Api.base}users');

    List<User> users =
        response.data.map<User>((element) => User.fromJson(element)).toList();

    print(users);

    return users;
  }

  @override
  Future<User> getSingleUser(int id) async {
    var response = await _dio.get('${Api.base}users/$id');
    User user = User.fromJson(response.data);

    print(user);

    return user;
  }
}
