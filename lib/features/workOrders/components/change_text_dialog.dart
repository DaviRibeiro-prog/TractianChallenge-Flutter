import 'package:flutter/material.dart';
import 'package:tractian_challenge/models/workOrders/work_order_model.dart';

import '../../../utils/colors.dart';
import '../../../utils/components/custom_button.dart';

class ChangeTextDialog {
  openDialog(BuildContext context, List<WorkOrder> workOrders, type) async {
    String error = '';
    String newText = '';
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
                          newText = e;
                        },
                        autocorrect: false,
                        autofocus: false,
                        enableSuggestions: false,
                        minLines: 1,
                        maxLines: 2,
                        style: TextStyle(color: Colors.white, fontSize: 25),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: type == 'title'
                                ? 'New Name'
                                : 'New Description',
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
                      SizedBox(height: 20),
                      SizedBox(
                        width: 320.0,
                        child: CustomElevatedButtom(
                          onPress: () {
                            if (newText.isEmpty) {
                              setState.call(() {
                                error = 'Enter a text please!';
                              });
                            } else if (type == 'title' &&
                                workOrders.any(
                                    (element) => element.title == newText)) {
                              setState.call(() {
                                error = 'This task already exists';
                              });
                            } else {
                              return Navigator.pop(context, newText);
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
