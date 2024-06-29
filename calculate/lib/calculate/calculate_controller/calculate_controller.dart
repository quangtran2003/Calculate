import 'package:calculate/calculate/calculate_model/opera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../const/color.dart';

class CalculateController extends GetxController {
  final RxString input = ''.obs;

  final RxString output = ''.obs;

  final RxBool isVertical = true.obs;

  List<Opera> operas = [
    Opera(name: "C"),
    Opera(name: "%"),
    Opera(name: "del", icon: Icons.backspace),
    Opera(name: "+"),
    Opera(name: "7", color: blackColor),
    Opera(name: "8", color: blackColor),
    Opera(name: "9", color: blackColor),
    Opera(name: "-"),
    Opera(name: "4", color: blackColor),
    Opera(name: "5", color: blackColor),
    Opera(name: "6", color: blackColor),
    Opera(name: "x"),
    Opera(name: "1", color: blackColor),
    Opera(name: "2", color: blackColor),
    Opera(name: "3", color: blackColor),
    Opera(name: "/"),
    Opera(name: "turn", icon: Icons.loop_sharp),
    Opera(name: "0", color: blackColor),
    Opera(name: ".", color: blackColor),
    Opera(name: "="),
  ];

  void buttonPressed(String buttonText) {
    switch (buttonText) {
      case "C":
        // Xóa toàn bộ input và output
        input.value = "";
        output.value = "";
        break;
      case "del":
        // Xóa ký tự cuối cùng của input
        if (input.value.isNotEmpty) {
          input.value = input.value.substring(0, input.value.length - 1);
        }
        break;
      case "=":
        // Tính toán kết quả
        _calculateResult();
        break;
      default:
        // Thêm ký tự vào input khi nhấn các nút khác
        input.value += buttonText;
        break;
    }
  }

  void _calculateResult() {
    try {
      // Thay thế các ký tự x thành * để tính toán
      final expression = input.value.replaceAll('x', '*');
      // Đánh giá biểu thức và tính toán kết quả
      final result = _evaluateExpression(expression);
      // Cập nhật kết quả vào output
      output.value = result.toString();
    } catch (e) {
      // Hiển thị lỗi nếu có
      output.value = "Lỗi";
    }
  }

  double _evaluateExpression(String expression) {
    List<String> tokens = _tokenize(expression); // Tách biểu thức => các tokens
    List<double> values = []; // Danh sách lưu trữ các giá trị số
    List<String> ops = []; // Danh sách lưu trữ các toán tử

    for (int i = 0; i < tokens.length; i++) {
      String token = tokens[i];

      if (double.tryParse(token) != null) {
        // Nếu token là số, thêm vào danh sách giá trị
        values.add(double.parse(token));
      } else if (_isOperator(token)) {
        // Nếu token là toán tử, thực hiện các phép toán có độ ưu tiên cao hơn hoặc bằng trước
        while (ops.isNotEmpty && _precedence(ops.last) >= _precedence(token)) {
          values.add(_applyOperation(
              ops.removeLast(), values.removeLast(), values.removeLast()));
        }
        ops.add(token);
      }
    }

    // Thực hiện các phép toán còn lại
    while (ops.isNotEmpty) {
      values.add(_applyOperation(
          ops.removeLast(), values.removeLast(), values.removeLast()));
    }

    return values.last;
  }

  //hàm tách chuỗi input thành 1 list string trong đó mỗi phần tử là 1 số hoặc 1 toán tử
  List<String> _tokenize(String expression) {
    List<String> listTokens = []; // Danh sách lưu trữ các tokens
    StringBuffer token = StringBuffer();

    for (int i = 0; i < expression.length; i++) {
      // Nếu ký tự là toán tử thêm token hiện tại vào danh sách và khởi tạo token mới
      if (_isOperator(expression[i])) {
        if (token.isNotEmpty) {
          listTokens.add(token.toString());
          token.clear();
        }
        listTokens.add(expression[i]);
      } else {
        // Nếu ký tự là số, thêm vào token hiện tại
        token.write(expression[i]);
      }
    }
    // check phần tử cuối và thêm vào danh sách tokens
    if (token.isNotEmpty) {
      listTokens.add(token.toString());
    }

    return listTokens;
  }

  // Kiểm tra token có phải là toán tử không
  bool _isOperator(String token) {
    return token == '+' ||
        token == '-' ||
        token == '*' ||
        token == '/' ||
        token == '%';
  }

  // Trả về độ ưu tiên của toán tử
  int _precedence(String operator) {
    if (operator == '+' || operator == '-') return 1;
    if (operator == '*' || operator == '/' || operator == '%') return 2;
    return 0;
  }

  // Thực hiện phép toán dựa trên toán tử và hai giá trị
  double _applyOperation(String operator, double b, double a) {
    switch (operator) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '*':
        return a * b;
      case '/':
        if (b == 0) {
          // Hiển thị thông báo lỗi khi chia cho 0
          Get.snackbar("Thông báo", 'Lỗi khi chia cho 0');
          throw ArgumentError('Division by zero');
        }
        return a / b;
      case '%':
        return a % b;
      default:
        return 0;
    }
  }

//xoay màn hình
  void rotateScreen() {
    if (isVertical.value) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    isVertical.toggle();
  }
}
