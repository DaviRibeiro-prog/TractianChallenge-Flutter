import 'package:flutter/material.dart';
import 'package:tractian_challenge/utils/colors.dart';

class BaseAppBar extends StatelessWidget {
  const BaseAppBar({super.key, required this.title, this.actions});
  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.main,
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 23),
      ),
      actions: actions,
    );
  }
}
