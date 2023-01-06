import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_challenge/features/assets/assets_controller.dart';
import 'package:tractian_challenge/features/assets/repo/assets_repository.dart';
import 'package:tractian_challenge/features/main/main_controller.dart';
import 'package:tractian_challenge/features/main/repo/main_repository.dart';
import 'package:tractian_challenge/features/workOrders/repo/work_orders_repository.dart';
import 'package:tractian_challenge/features/workOrders/work_controller.dart';
import 'package:tractian_challenge/utils/colors.dart';
import 'package:tractian_challenge/utils/images/main.dart';
import 'package:tractian_challenge/utils/singletons/main_singleton.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AssetsController _assetsController =
      AssetsController(AssetsRepository());

  final WorkOrdersController _workOrdersController =
      WorkOrdersController(WorkOrdersRepository());

  final MainController _mainController = MainController(MainRepository());

  final mainSingleton = Modular.get<MainSingleton>();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    try {
      mainSingleton.assets = await _assetsController.getAssets();
      mainSingleton.workOrders = await _workOrdersController.getWorkOrders();
      mainSingleton.users = await _mainController.getUsers();

      print(mainSingleton.users);
      print(mainSingleton.assets);
      print(mainSingleton.workOrders);

      Modular.to.pushReplacementNamed('/menu');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomColors.main,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Center(
              child: Image.asset(
            Images.tractianLogo,
            color: Colors.white,
          )),
        ),
      ),
    );
  }
}
