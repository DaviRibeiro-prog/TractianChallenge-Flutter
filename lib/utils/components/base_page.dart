import 'package:flutter/material.dart';
import 'package:tractian_challenge/utils/colors.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key, required this.child, this.appBar, this.onWillPop});
  final Widget child;
  final dynamic appBar;
  final Function? onWillPop;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (onWillPop != null) {
          onWillPop!();
        }
        return false;
      },
      child: Scaffold(
        // ignore: unnecessary_null_in_if_null_operators
        appBar: appBar != null
            ? PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: appBar,
              )
            : null,
        backgroundColor: CustomColors.background,
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: child),
      ),
    );
  }
}
