import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:enit_project_app/utils/tabs.dart';
import 'Board/view_boardpage.dart';
import 'Login/Login/view_loginpage.dart';
import 'Home/view_homepage.dart';
import 'Mypage/view_mypage.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Get.put(NavigationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NavigationController navigationController =
      Get.find(); // 이미 Get.put로 생성된 인스턴스를 가져옵니다.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'SKYBORI'),
      themeMode: ThemeMode.system,
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/board', page: () => BoardPage()),
        GetPage(name: '/mypage', page: () => MyPage()),
      ],
      initialRoute: '/login',
      home: Obx(() => IndexedStack(
            index: navigationController.tabIndex.value,
            children: [
              LoginPage(),
              HomePage(),
              BoardPage(),
              MyPage(),
            ],
          )),
    );
  }
}
