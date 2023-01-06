import 'package:tractian_challenge/models/assets/asset_model.dart';
import 'package:tractian_challenge/models/user_model.dart';
import 'package:tractian_challenge/models/workOrders/work_order_model.dart';

class MainSingleton {
  int currentIndex = 0;
  List<WorkOrder> workOrders = [];
  List<Asset> assets = [];
  List<User> users = [];
}
