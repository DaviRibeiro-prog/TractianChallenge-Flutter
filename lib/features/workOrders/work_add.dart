import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_challenge/features/workOrders/components/add_task_dialog.dart';
import 'package:tractian_challenge/main.dart';
import 'package:tractian_challenge/models/workOrders/work_order_model.dart';
import 'package:tractian_challenge/utils/colors.dart';
import 'package:tractian_challenge/utils/components/base_appbar.dart';
import 'package:tractian_challenge/utils/components/base_page.dart';
import 'package:tractian_challenge/utils/components/custom_button.dart';
import 'package:tractian_challenge/utils/components/custom_dropdown.dart';

import '../../models/workOrders/checklist_model.dart';
import '../../utils/singletons/main_singleton.dart';

class NewWorkPage extends StatefulWidget {
  const NewWorkPage({super.key});

  @override
  State<NewWorkPage> createState() => _NewWorkPageState();
}

class _NewWorkPageState extends State<NewWorkPage> {
  final mainSingleton = Modular.get<MainSingleton>();

  //
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  //
  dynamic asset;
  dynamic assetId;
  dynamic user;
  dynamic userId;
  List<String> assetsList = [];
  List<String> usersList = [];
  List<TaskTile> tasksList = [];
  //
  var priority = 'high';
  //
  @override
  void initState() {
    super.initState();
    for (var element in mainSingleton.assets) {
      assetsList.add(element.name);
    }
    asset = assetsList[0];
    assetId =
        mainSingleton.assets.firstWhere((element) => element.name == asset).id;
    //.
    for (var element in mainSingleton.users) {
      usersList.add(element.name);
    }
    user = usersList[0];
    userId =
        mainSingleton.users.firstWhere((element) => element.name == user).id;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BasePage(
        onWillPop: () {
          Navigator.pop(context);
        },
        appBar: BaseAppBar(title: 'New Work Order'),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 32, right: 32, top: 40, bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                // TEXTFIELDS (TITLE AND DESCRPITON)
                //
                getLabel('Title'),
                SizedBox(height: 20),
                getTextField('What needs to be done?', titleController),
                SizedBox(height: 35),
                getLabel('Description'),
                SizedBox(height: 20),
                getTextField('Add a description', descriptionController),
                SizedBox(height: 50),
                //
                // DROPDOWNS - (ASSET AND USER)
                //
                Text(
                  'Asset',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                SizedBox(height: 20),
                CustomDropDown(
                    value: asset,
                    list: assetsList,
                    onChanged: (e) {
                      setState(() {
                        asset = e;
                        assetId = mainSingleton.assets
                            .firstWhere((element) => element.name == asset)
                            .id;
                      });
                    }),
                SizedBox(height: 30),
                Text(
                  'Assignees',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                SizedBox(height: 20),
                CustomDropDown(
                    value: user,
                    list: usersList,
                    onChanged: (e) {
                      setState(() {
                        user = e;
                        userId = mainSingleton.users
                            .firstWhere((element) => element.name == user)
                            .id;
                      });
                    }),
                SizedBox(height: 50),
                //
                // PRIORITY
                //
                getLabel('Priority'),
                SizedBox(height: 29),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getPriorityBox('Low'),
                    SizedBox(width: 15),
                    getPriorityBox('Medium'),
                    SizedBox(width: 15),
                    getPriorityBox('High'),
                  ],
                ),
                SizedBox(height: 50),
                //
                // CHECKLIST
                //
                getLabel('Procedures Tasks List'),
                SizedBox(
                  height: 35,
                ),
                tasksList.isEmpty
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
                        itemCount: tasksList.length,
                        itemBuilder: (context, index) {
                          TaskTile tasksListTile = tasksList[index];
                          return GestureDetector(
                            onTap: () {
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
                                        tasksListTile.completed = e!;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  tasksListTile.task,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        tasksList.removeWhere((element) =>
                                            element.task == tasksListTile.task);
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
                    var newTask =
                        await TaskDialog().openDialog(context, tasksList);
                    setState(() {
                      if (newTask != null) {
                        tasksList.add(newTask);
                      }
                    });
                  },
                ),
                SizedBox(height: 80),
                //
                // SAVE BUTTON
                //

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
      ),
    );
  }

  saveFunction() {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter the title and description fields!"),
      ));
      return;
    }

    if (mainSingleton.workOrders
        .any((element) => element.title == titleController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("This work order alredy exists! (title)"),
      ));
      return;
    }

    WorkOrder newWorkOrder = WorkOrder(
        assetId: assetId,
        assignedUserIds: [userId],
        tasksList: tasksList,
        description: descriptionController.text,
        id: mainSingleton.workOrders.map<int>((e) => e.id).reduce(max) + 1,
        priority: priority,
        status: 'open',
        title: titleController.text);

    print(newWorkOrder);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Order Work successfully created!",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      backgroundColor: Colors.green,
    ));

    mainSingleton.workOrders.add(newWorkOrder);

    Navigator.pop(context);
  }

  getPriorityBox(String type) {
    Color color;
    Function() onTap;

    if (type == 'High') {
      color = Colors.red;
      onTap = () {
        setState(() {
          priority = 'high';
        });
      };
    } else if (type == 'Low') {
      color = Colors.green;
      onTap = () {
        setState(() {
          priority = 'low';
        });
      };
    } else {
      onTap = () {
        setState(() {
          priority = 'medium';
        });
      };
      color = Colors.orange;
    }
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 47,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: color),
            color: type.toLowerCase() == priority ? color : Colors.transparent,
          ),
          child: Center(
              child: Text(
            type,
            style: TextStyle(
                color: type.toLowerCase() == priority ? Colors.white : color,
                fontSize: 20),
          )),
        ),
      ),
    );
  }

//
//
//

  getLabel(title) {
    return Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 25),
    );
  }

  getTextField(hintText, controller) {
    return TextField(
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: TextInputType.text,
      style: TextStyle(
          color: Colors.white, fontSize: 22, decoration: TextDecoration.none),
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white38, width: 2),
          ),
          hintStyle: TextStyle(color: Colors.white54)),
    );
  }
}
