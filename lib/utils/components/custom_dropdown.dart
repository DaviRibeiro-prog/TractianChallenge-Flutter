import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown(
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

class _MyHomePageState extends State<CustomDropDown> {
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
      itemWidth: 200,
      itemTextstyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
      boxTextstyle: TextStyle(fontSize: 20, color: Colors.white),
      boxPadding: EdgeInsets.fromLTRB(13, 12, 13, 12),
      boxWidth: MediaQuery.of(context).size.width,
      boxHeight: 50,
      boxDecoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black.withOpacity(0.4))),
      hint: Text(
        widget.value,
        style: TextStyle(fontSize: 20),
      ),
      value: widget.value,
      items: buildDropdownTestItems(widget.list),
      onChanged: widget.onChanged,
    );
  }
}
