import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/components/custom_button.dart';

class AlertDialogComponent {
  openDialog(BuildContext context, text) async {
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
                      left: 30, right: 30, top: 30, bottom: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                              width: 100,
                              height: 40,
                              child: CustomElevatedButtom(
                                color: Colors.green,
                                child: Text(
                                  'Sim',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPress: () {
                                  return Navigator.pop(context, true);
                                },
                              )),
                          SizedBox(width: 20),
                          SizedBox(
                              width: 100,
                              height: 40,
                              child: CustomElevatedButtom(
                                color: Colors.red,
                                child: Text(
                                  'Não',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPress: () {
                                  Navigator.pop(context);
                                },
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        }).then((value) => value);
  }
}
