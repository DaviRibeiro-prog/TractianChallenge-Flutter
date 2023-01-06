// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    var color, text;
    if (status == 'inAlert') {
      text = 'In Alert';
      color = Colors.red;
    } else if (status == 'unplannedStop') {
      color = Colors.orange;
      text = 'Unplanned Stop';
    } else if (status == 'inOperation') {
      color = Colors.green;
      text = 'In Operation';
    } else if (status == 'inDowntime') {
      color = Colors.blue;
      text = 'In Downtime';
    } else {
      color = Colors.grey;
      text = 'Offline';
    }

    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 5, top: 5, right: 10),
        child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
