import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:enit_project_app/utils/tabs.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController = Get.find();

    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Obx(
                () => Text(
                    "Bye Selected Page: ${navigationController.tabIndex.value}"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
