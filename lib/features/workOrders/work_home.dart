import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_challenge/models/workOrders/work_order_model.dart';
import 'package:tractian_challenge/utils/colors.dart';
import 'package:tractian_challenge/utils/components/base_page.dart';
import 'package:tractian_challenge/utils/components/custom_button.dart';

import '../../utils/components/custom_textfield.dart';
import '../../utils/singletons/main_singleton.dart';

class WorkOrdersHome extends StatefulWidget {
  const WorkOrdersHome({super.key});

  @override
  State<WorkOrdersHome> createState() => _WorkOrdersHomeState();
}

class _WorkOrdersHomeState extends State<WorkOrdersHome> {
  final mainSingleton = Modular.get<MainSingleton>();
  var filteredList = [];
  bool filter = false;

  @override
  void initState() {
    super.initState();
    restartList();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    onChanged: (text) {
                      if (text.isEmpty) {
                        restartList();
                      } else {
                        if (!filter) {
                          filteredList.clear();
                        }
                        startFilter(text);
                      }
                    },
                    hintText: 'Search work order...',
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 80,
                  height: 50,
                  child: CustomElevatedButtom(
                    onPress: () {
                      Modular.to.pushNamed('/newWork').then((value) {
                        restartList();
                      });
                    },
                    color: CustomColors.main,
                    child: Text(
                      '+',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Text(
                      'No work order found',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54, fontSize: 30),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.all(20),
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                          left: 12, right: 12, bottom: 30, top: 30),
                      child: Container(
                        height: 1.5,
                        color: Colors.white24,
                      ),
                    ),
                    itemCount: filteredList.length,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      WorkOrder workOrder = filteredList[index];
                      return GestureDetector(
                        onTap: () {
                          Modular.to
                              .pushNamed('workInfo', arguments: workOrder)
                              .then((value) => {restartList()});
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 4.5,
                              child: Column(
                                children: [
                                  getIcon(workOrder.status),
                                  SizedBox(height: 10),
                                  Text(
                                    maxLines: 1,
                                    workOrder.status.toCapitalized(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 25),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 200,
                                  child: Text(
                                    maxLines: 2,
                                    workOrder.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text('Work ID: ' + workOrder.id.toString(),
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 20)),
                                SizedBox(height: 12),
                                Visibility(
                                  visible: workOrder.priority == 'high' &&
                                          workOrder.status != 'completed'
                                      ? true
                                      : false,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          bottom: 5,
                                          top: 5,
                                          right: 10),
                                      child: Text('Important',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  child: Icon(
                                    Icons.arrow_right,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
          ),
        ],
      ),
    );
  }

  separePriority() {
    //
    // METHOD TO SEPARATE THE LIST BY PRIORITY (HIGH - MEDIUM - LOW - DONE)
    //
    List<WorkOrder> doneItems = [];
    //
    List<WorkOrder> highInProgressItems = [];
    List<WorkOrder> highOpenItems = [];
    //
    List<WorkOrder> mediumInProgressItems = [];
    List<WorkOrder> mediumOpenItems = [];
    //
    List<WorkOrder> lowInProgressItems = [];
    List<WorkOrder> lowOpenItems = [];

    for (WorkOrder element in filteredList) {
      if (element.status == 'completed') {
        doneItems.add(element);
      } else {
        if (element.priority == 'high') {
          if (element.status == 'in progress') {
            highInProgressItems.add(element);
          } else {
            highOpenItems.add(element);
          }
        } else if (element.priority == 'medium') {
          if (element.status == 'in progress') {
            mediumInProgressItems.add(element);
          } else {
            mediumOpenItems.add(element);
          }
        } else {
          if (element.status == 'in progress') {
            lowInProgressItems.add(element);
          } else {
            lowOpenItems.add(element);
          }
        }
      }
    }

    filteredList.clear();
    final finalList = [];

    //
    // FINAL SORT (BY ID)
    //

    highInProgressItems.sort((a, b) => a.id.compareTo(b.id));
    highOpenItems.sort((a, b) => a.id.compareTo(b.id));
    mediumOpenItems.sort((a, b) => a.id.compareTo(b.id));
    mediumInProgressItems.sort((a, b) => a.id.compareTo(b.id));
    lowInProgressItems.sort((a, b) => a.id.compareTo(b.id));
    lowOpenItems.sort((a, b) => a.id.compareTo(b.id));
    doneItems.sort((a, b) => a.id.compareTo(b.id));

    ////
    //  CREATING THE FINAL SORTED LIST
    ///

    for (var element in highInProgressItems) {
      //
      // 1- ADDING THE 'HIGH' (IN PROGRESS) ITEMS
      //
      finalList.add(element);
    }
    for (var element in highOpenItems) {
      //
      // 2- ADDING THE 'HIGH' (OPEN) ITEMS
      //
      finalList.add(element);
    }
    for (var element in mediumInProgressItems) {
      //
      // 3- ADDING THE 'MEDIUM' (IN PROGRESS) ITEMS
      //
      finalList.add(element);
    }
    for (var element in lowInProgressItems) {
      //
      //  4- ADDING THE 'LOW' (IN PROGRESS) ITEMS
      //
      finalList.add(element);
    }
    for (var element in lowOpenItems) {
      //
      // 5- ADDING THE 'LOW' (OPEN) ITEMS
      //
      finalList.add(element);
    }

    for (var element in doneItems) {
      //
      // AND FINALLY THE 'DONE' ITEMS (COMPLETED, NOT SO IMPORTANT)
      //
      finalList.add(element);
    }
    for (var element in finalList) {
      //
      // REPLACING THE ORIGINAL FILTRED LIST WITH THE FINAL SORTED LIST
      //
      filteredList.add(element);
    }
    setState(() {});
  }

  startFilter(String text) {
    //
    // METHOD FOR THE TEXTFIELD (FILTER)
    //
    for (var element in mainSingleton.workOrders) {
      if (element.title.toUpperCase().contains(text.toUpperCase())) {
        filteredList.add(element);
      }
    }
    separePriority();
  }

  restartList() {
    //
    //  METHOD TO CLEAR THE FILTERED LIST AND REPLACE WITH THE ORIGINAL ONE
    //
    filteredList.clear();
    for (var element in mainSingleton.workOrders) {
      filteredList.add(element);
    }
    separePriority();
  }

  getIcon(String status) {
    if (status == 'completed') {
      return Icon(
        Icons.done,
        color: Colors.green,
        size: 55,
      );
    } else if (status == 'in progress') {
      return Icon(
        Icons.pending,
        color: Colors.yellow,
        size: 55,
      );
    } else {
      return Icon(
        Icons.lock_open,
        color: Colors.blue,
        size: 55,
      );
    }
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
