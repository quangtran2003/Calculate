import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculate/calculate/calculate_controller/calculate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/color.dart';
import '../calculate_model/opera.dart';

part 'calculate_widet.dart';

class CalculateScreen extends GetView<CalculateController> {
  const CalculateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          _buildInOutput(controller.input),
          _buildInOutput(controller.output),
          _buildKeyBoard()
        ],
      ),
    );
  }

  Expanded _buildKeyBoard() {
    return Expanded(
      child: Obx(
        () => Container(
          alignment: Alignment.bottomCenter,
          child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: controller.isVertical.value ? 4 : 7,
              crossAxisSpacing: 2,
              childAspectRatio: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: controller.operas.length,
            itemBuilder: (context, index) {
              return buildChip(controller.operas[index], controller);
            },
          ),
        ),
      ),
    );
  }

  Container _buildInOutput(RxString rxString) {
    return Container(
      height: 60,
      alignment: Alignment.topRight,
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 12.0,
      ),
      child: Obx(
        () => AutoSizeText(
          rxString.value,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
