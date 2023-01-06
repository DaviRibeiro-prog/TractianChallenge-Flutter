import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomSmartRefresh extends StatelessWidget {
  const CustomSmartRefresh(
      {Key? key,
      this.loading,
      this.loadingBody,
      required this.setState,
      required this.body,
      required this.controller,
      required this.child})
      : super(key: key);
  final Widget child;
  final bool? loading;
  final Function setState;
  final Function body;
  final Function? loadingBody;
  final RefreshController controller;
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: loading == null ? false : loading!,
        controller: controller,
        onLoading: loading != null
            ? () async {
                try {
                  await loadingBody!();
                } catch (e) {
                  print(e);
                  final SnackBar snackBar = SnackBar(
                    content: Text(
                      "Erro de conexão. Tente novamente mais tarde.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red[400],
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                controller.loadComplete();
                setState();
              }
            : null,
        onRefresh: () async {
          try {
            await body();
          } catch (e) {
            print(e);
            final SnackBar snackBar = SnackBar(
              content: Text(
                "Erro de conexão. Tente novamente mais tarde.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red[400],
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          controller.refreshCompleted();
          setState();
        },
        child: child);
  }
}
