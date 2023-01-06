import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:tractian_challenge/utils/colors.dart';

class DropDownPriority extends StatefulWidget {
  const DropDownPriority(
      {Key? key,
      required this.list,
      this.value,
      required this.onChanged,
      this.icon})
      : super(key: key);
  final Widget? icon;
  final List list;
  final dynamic value;
  final void Function(Object?) onChanged;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DropDownPriority> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DropdownMenuItem<Object?>> buildDropdownTestItems(List list) {
    List<DropdownMenuItem<Object?>> items = [];
    for (var i in list) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            i,
          ),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownBelow(
      icon: widget.icon,
      dropdownColor: CustomColors.main,
      itemWidth: 200,
      itemTextstyle: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
      boxTextstyle: TextStyle(fontSize: 18, color: Colors.white),
      boxPadding:
          EdgeInsets.fromLTRB(30, 0, widget.value == 'Medium' ? 30 : 0, 0),
      boxHeight: 38,
      boxDecoration: BoxDecoration(
        color: getColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      hint: Text(
        widget.value,
        style: TextStyle(fontSize: 18),
      ),
      value: widget.value,
      items: buildDropdownTestItems(widget.list),
      onChanged: widget.onChanged,
    );
  }

  getColor() {
    if (widget.value == 'High') {
      return Colors.red;
    } else if (widget.value == 'Medium') {
      return Colors.orange;
    } else {
      return Colors.grey;
    }
  }
}
