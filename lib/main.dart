import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_challenge/modular.dart';
import 'package:tractian_challenge/utils/colors.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      color: CustomColors.main,
    );
  }
}
