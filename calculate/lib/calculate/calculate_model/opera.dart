
import 'package:flutter/material.dart';

import '../../const/color.dart';

class Opera {
  final String name;
  final Color? color;
  final IconData? icon;

  Opera({
    required this.name,
     this.color = primaryColor,
     this.icon,
  });
}
