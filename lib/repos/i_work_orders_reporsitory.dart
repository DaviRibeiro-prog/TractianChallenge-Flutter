import 'package:tractian_challenge/models/workOrders/work_order_model.dart';

abstract class IWorkOrdersRepository {
  Future<List<WorkOrder>> getWorkOrders();
  Future<WorkOrder> getSingleWorkOrder(int id);
}
