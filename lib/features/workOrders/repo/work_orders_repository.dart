import 'package:dio/dio.dart';
import 'package:tractian_challenge/models/workOrders/work_order_model.dart';
import 'package:tractian_challenge/repos/i_work_orders_reporsitory.dart';

import '../../../repos/api_url.dart';

class WorkOrdersRepository extends IWorkOrdersRepository {
  final Dio _dio = Dio();

  @override
  Future<List<WorkOrder>> getWorkOrders() async {
    var response = await _dio.get('${Api.base}workorders');

    List<WorkOrder> workOrders = response.data
        .map<WorkOrder>((element) => WorkOrder.fromJson(element))
        .toList();

    print(workOrders);

    return workOrders;
  }

  @override
  Future<WorkOrder> getSingleWorkOrder(int id) async {
    var response = await _dio.get('${Api.base}workorders/$id');
    WorkOrder workOrder = WorkOrder.fromJson(response.data);

    print(workOrder);

    return workOrder;
  }
}
