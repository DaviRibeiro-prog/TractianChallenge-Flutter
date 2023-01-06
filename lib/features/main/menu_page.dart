import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_challenge/features/QRcode/qrcode_page.dart';
import 'package:tractian_challenge/features/assets/assets_home.dart';
import 'package:tractian_challenge/features/workOrders/work_home.dart';
import 'package:tractian_challenge/utils/colors.dart';
import 'package:tractian_challenge/utils/images/main.dart';

import '../../utils/singletons/main_singleton.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final mainSingleton = Modular.get<MainSingleton>();

  final List<Widget> _tabs = [WorkOrdersHome(), AssetsHomePage(), QRPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomColors.main,
        title: SizedBox(
            width: 165,
            child: Image.asset(
              Images.tractianLogo,
              color: Colors.white,
            )),
      ),
      body: _tabs[mainSingleton.currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.yellow,
          textTheme: Theme.of(context).textTheme.copyWith(
                  caption: TextStyle(
                color: CustomColors.main,
              )),
        ),
        child: BottomNavigationBar(
          backgroundColor: CustomColors.main,
          currentIndex: mainSingleton.currentIndex,
          iconSize: 35,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          unselectedItemColor: Colors.white60,
          fixedColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.book), label: 'Work Orders'),
            BottomNavigationBarItem(
                icon: Icon(Icons.app_settings_alt_sharp), label: 'Assets'),
            BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QRcode'),
          ],
          onTap: (index) {
            setState(() {
              mainSingleton.currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
