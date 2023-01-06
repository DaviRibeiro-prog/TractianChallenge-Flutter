import 'package:tractian_challenge/repos/i_work_orders_reporsitory.dart';

import '../../models/workOrders/work_order_model.dart';

class WorkOrdersController {
  final IWorkOrdersRepository repo;

  WorkOrdersController(this.repo);

  Future<List<WorkOrder>> getWorkOrders() async {
    var response = await repo.getWorkOrders();
    return response;
  }

  Future<WorkOrder> getSingleWorkOrder(int id) async {
    var response = repo.getSingleWorkOrder(id);
    return response;
  }
}
