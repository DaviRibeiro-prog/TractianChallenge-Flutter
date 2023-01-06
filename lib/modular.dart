import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_challenge/features/assets/assets_info.dart';
import 'package:tractian_challenge/features/main/menu_page.dart';
import 'package:tractian_challenge/features/main/splash_screen.dart';
import 'package:tractian_challenge/features/workOrders/work_add.dart';
import 'package:tractian_challenge/features/workOrders/work_info.dart';
import 'package:tractian_challenge/utils/singletons/main_singleton.dart';

// import 'package:send_email_project/app/views/splashScreen_view.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MainSingleton()),
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        transition: TransitionType.noTransition,
        child: (_, __) => const SplashScreen()),
    ChildRoute('/menu',
        transition: TransitionType.noTransition,
        child: (_, __) => const Menu()),
    ChildRoute('/newWork',
        transition: TransitionType.noTransition,
        child: (_, __) => const NewWorkPage()),
    ChildRoute('/workInfo',
        transition: TransitionType.noTransition,
        child: (_, __) => const WorkInfoPage()),
    ChildRoute('/assetInfo',
        transition: TransitionType.noTransition,
        child: (_, __) => const AssetInfoPage()),
  ];
}
