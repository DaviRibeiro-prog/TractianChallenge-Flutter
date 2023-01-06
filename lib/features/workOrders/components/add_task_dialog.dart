import 'package:flutter/material.dart';
import 'package:tractian_challenge/models/workOrders/checklist_model.dart';

import '../../../utils/colors.dart';
import '../../../utils/components/custom_button.dart';

class TaskDialog {
  openDialog(BuildContext context, List<TaskTile> tasksList) async {
    bool checked = false;
    String error = '';
    String task = '';
    return await showDialog(
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (e) {
                          task = e;
                        },
                        autocorrect: false,
                        autofocus: false,
                        enableSuggestions: false,
                        minLines: 1,
                        maxLines: 2,
                        style: TextStyle(color: Colors.white, fontSize: 25),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'New task',
                            hintStyle:
                                TextStyle(color: Colors.white54, fontSize: 25)),
                      ),
                      SizedBox(height: 3),
                      error.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: Text(
                                error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 17.5),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          checked = !checked;
                          setState.call(() => {});
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
                                  hoverColor: Colors.white,
                                  focusColor: Colors.white,
                                  checkColor: Colors.white,
                                  activeColor: Colors.green,
                                  value: checked,
                                  onChanged: (e) {
                                    checked = e!;
                                    setState.call(() => {});
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Checked',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 320.0,
                        child: CustomElevatedButtom(
                          onPress: () {
                            if (task.isEmpty) {
                              setState.call(() {
                                error = 'Missing new task text';
                              });
                            } else if (tasksList
                                .any((element) => element.task == task)) {
                              setState.call(() {
                                error = 'This task already exists';
                              });
                            } else {
                              var newTask =
                                  TaskTile(completed: checked, task: task);
                              return Navigator.pop(context, newTask);
                            }
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          color: CustomColors.background,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        }).then((value) => value);
  }
}
