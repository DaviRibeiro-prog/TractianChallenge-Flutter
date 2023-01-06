import 'package:tractian_challenge/models/user_model.dart';

abstract class IMainRepository {
  Future<List<User>> getUsers();
  Future<User> getSingleUser(int id);
}
