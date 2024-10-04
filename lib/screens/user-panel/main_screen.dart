import 'package:flutter/material.dart';
import 'package:loot_bazar/widgets/custom_drawer_widget.dart';

import '../../utils/app_constant.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          AppConstant.appMainName,
          style: const TextStyle(
            color: AppConstant.appWhiteColor,
          ),
        ),
        iconTheme:
            const IconThemeData(color: AppConstant.appWhiteColor, size: 30),
      ),
      drawer: const DrawerWidget(),
    );
  }
}
