import 'package:calculate/calculate/caculate_binding/calculate_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'calculate/calculate_screen/calculate_screen.dart';
import 'const/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: CALCULATE_SCREEN,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: CALCULATE_SCREEN,
            page: () => const CalculateScreen(),
            binding: CalculateBinding())
      ],
    );
  }
}
