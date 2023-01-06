import 'package:tractian_challenge/repos/i_main_repository.dart';

import '../../models/user_model.dart';

class MainController {
  final IMainRepository repo;

  MainController(this.repo);

  Future<List<User>> getUsers() async {
    var response = await repo.getUsers();
    return response;
  }

  Future<User> getSingleUser(int id) async {
    var response = await repo.getSingleUser(id);
    return response;
  }
}
