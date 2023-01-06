import 'package:flutter/material.dart';
import 'package:tractian_challenge/models/workOrders/work_order_model.dart';

import '../../../utils/colors.dart';
import '../../../utils/components/custom_button.dart';

class AssetOrdersDialog {
  openDialog(BuildContext context, List<WorkOrder> workOrders) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: CustomColors.main,
                ),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 30);
                              },
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: workOrders.length,
                              itemBuilder: ((context, index) {
                                WorkOrder workOrder = workOrders[index];
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '• ' + workOrder.description,
                                      maxLines: 10,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      workOrder.description,
                                      maxLines: 10,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.white60,
                                          fontSize: 20),
                                    ),
                                  ],
                                );
                              })),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30, right: 15, bottom: 10),
                            child: SizedBox(
                              height: 60,
                              width: 120,
                              child: CustomElevatedButtom(
                                color: Colors.green,
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPress: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            );
          });
        });
  }
}
