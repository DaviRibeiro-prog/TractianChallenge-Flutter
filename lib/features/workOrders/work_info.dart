import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_challenge/features/workOrders/components/change_text_dialog.dart';
import 'package:tractian_challenge/features/workOrders/components/dropdown_priority.dart';
import 'package:tractian_challenge/utils/components/custom_alert_dialog.dart';
import 'package:tractian_challenge/utils/components/base_appbar.dart';
import 'package:tractian_challenge/utils/components/base_page.dart';

import '../../models/user_model.dart';
import '../../models/workOrders/checklist_model.dart';
import '../../models/workOrders/work_order_model.dart';
import '../../utils/colors.dart';
import '../../utils/components/custom_button.dart';
import '../../utils/singletons/main_singleton.dart';
import 'components/add_task_dialog.dart';

class WorkInfoPage extends StatefulWidget {
  const WorkInfoPage({super.key});

  @override
  State<WorkInfoPage> createState() => _WorkInfoPageState();
}

class _WorkInfoPageState extends State<WorkInfoPage> {
  final mainSingleton = Modular.get<MainSingleton>();
  WorkOrder? workOrder;
  User? user;
  List priorityList = ['High', 'Medium', 'Low'];
  bool changes = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (workOrder == null) {
      final arg = ModalRoute.of(context)!.settings.arguments as WorkOrder;
      var json = arg.toJson();
      workOrder = WorkOrder.fromJson(json);
      user = mainSingleton.users
          .firstWhere((element) => element.id == workOrder!.assignedUserIds[0]);
    }

    return BasePage(
      onWillPop: () async => await exitWarning(),
      appBar: BaseAppBar(
        title: 'Work Order Info',
        actions: [
          InkWell(
            onTap: () async {
              dynamic deleted = await AlertDialogComponent().openDialog(
                  context, 'Are you sure you want to delete work order?');

              if (deleted != null) {
                mainSingleton.workOrders.removeWhere(
                    (element) => element.title == workOrder!.title);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
            child: Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
          ),
          SizedBox(width: 30)
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 80, top: 40, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.engineering, color: Colors.white, size: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: Text(
                      workOrder!.title,
                      maxLines: 2,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      var newTitle = await ChangeTextDialog().openDialog(
                          context, mainSingleton.workOrders, 'title');
                      setState(() {
                        if (newTitle != null) {
                          workOrder!.title = newTitle;
                          changes = true;
                        }
                      });
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.white60,
                      size: 30,
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Status (Click to refresh)',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getStatusContainer('Open'),
                  getStatusContainer('In progress'),
                  getStatusContainer('Completed'),
                ],
              ),
              SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getLabel('Assignee'),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Text(
                                user!.name[0].toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            user!.name,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(width: 80),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getLabel('Priority'),
                      SizedBox(height: 15),
                      DropDownPriority(
                          value: workOrder!.priority.toCapitalized(),
                          list: priorityList,
                          onChanged: (e) {
                            String a = e.toString();
                            setState(() {
                              workOrder!.priority = a.toLowerCase();
                            });
                            changes = true;
                            print(workOrder);
                          }),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
              getLabel('Asset'),
              SizedBox(height: 25),
              Row(
                children: [
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: CachedNetworkImage(
                      imageUrl: mainSingleton.assets
                          .firstWhere(
                              (element) => element.id == workOrder!.assetId)
                          .image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(width: 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Text(
                      mainSingleton.assets
                          .firstWhere(
                              (element) => element.id == workOrder!.assetId)
                          .name,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  getLabel('Description'),
                  SizedBox(width: 25),
                  InkWell(
                    onTap: () async {
                      var newTitle = await ChangeTextDialog().openDialog(
                          context, mainSingleton.workOrders, 'description');
                      setState(() {
                        if (newTitle != null) {
                          workOrder!.description = newTitle;
                          changes = true;
                        }
                      });
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.white60,
                      size: 25,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  workOrder!.description,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: 50),
              getLabel('Procedures checklist'),
              SizedBox(height: 20),
              workOrder!.tasksList.isEmpty
                  ? Text(
                      'No Tasks Added',
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    )
                  : ListView.separated(
                      separatorBuilder: ((context, index) => SizedBox(
                            height: 20,
                          )),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: workOrder!.tasksList.length,
                      itemBuilder: (context, index) {
                        TaskTile tasksListTile = workOrder!.tasksList[index];
                        return GestureDetector(
                          onTap: () {
                            changes = true;

                            setState(() {
                              tasksListTile.completed =
                                  !tasksListTile.completed;
                            });
                          },
                          child: Row(
                            children: [
                              Transform.scale(
                                scale: 1.4,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.white,
                                  ),
                                  child: Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.green,
                                    value: tasksListTile.completed,
                                    onChanged: (e) {
                                      changes = true;

                                      tasksListTile.completed = e!;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.8,
                                child: Text(
                                  tasksListTile.task,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    changes = true;

                                    setState(() {
                                      workOrder!.tasksList.removeWhere(
                                          (element) =>
                                              element.task ==
                                              tasksListTile.task);
                                    });
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 35,
                                  )),
                              SizedBox(width: 20),
                            ],
                          ),
                        );
                      },
                    ),
              SizedBox(height: 30),
              CustomElevatedButtom(
                color: Colors.transparent,
                borderColor: CustomColors.background,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '+ Add Item',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                onPress: () async {
                  var newTask = await TaskDialog()
                      .openDialog(context, workOrder!.tasksList);
                  setState(() {
                    if (newTask != null) {
                      changes = true;

                      workOrder!.tasksList.add(newTask);
                    }
                  });
                },
              ),
              SizedBox(height: 50),
              Center(
                child: CustomElevatedButtom(
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.save,
                        size: 30,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  onPress: saveFunction,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  exitWarning() async {
    if (changes) {
      dynamic exit = await AlertDialogComponent().openDialog(context,
          'There have been changes, are you sure you want to exit without saving?');
      if (exit == null) {
        return;
      }
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  saveFunction() async {
    dynamic change = await AlertDialogComponent()
        .openDialog(context, 'Are you sure you want to save?');
    if (change != null) {
      mainSingleton.workOrders
          .removeWhere((element) => element.title == workOrder!.title);
      mainSingleton.workOrders.add(workOrder!);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  getLabel(text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  getStatusContainer(String type) {
    final color, icon, function, iconSize;
    bool selected = false;
    iconSize = 35.0;
    var iconDefaultColor = Colors.black;

    if (workOrder!.status == type.toLowerCase()) {
      selected = true;
    }

    if (type == 'Open') {
      color = Colors.blue;
      icon = Icon(Icons.lock_open,
          size: iconSize, color: selected ? iconDefaultColor : color);
      function = () {
        setState(() {
          workOrder!.status = 'open';
        });
      };
    } else if (type == 'In progress') {
      color = Colors.yellow;
      icon = Icon(Icons.pending,
          size: iconSize, color: selected ? iconDefaultColor : color);
      function = () {
        setState(() {
          workOrder!.status = 'in progress';
        });
      };
    } else {
      color = Colors.green;
      icon = Icon(Icons.done,
          size: iconSize, color: selected ? iconDefaultColor : color);
      function = () {
        setState(() {
          workOrder!.status = 'completed';
        });
      };
    }

    return GestureDetector(
      onTap: () {
        changes = true;
        function();
      },
      child: Container(
        width: 110,
        height: 90,
        decoration: BoxDecoration(
          color: !selected ? Colors.transparent : color,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              type,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: selected ? Colors.black : color,
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
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
