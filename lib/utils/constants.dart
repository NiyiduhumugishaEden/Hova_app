import 'package:flutter/material.dart';

const kItemColorThreshold = 5;

Color getItemColor(int quantity) {
  if (quantity == 0) {
    return Colors.red;
  } else if (quantity < kItemColorThreshold) {
    return Colors.yellow;
  } else {
    return Colors.green;
  }
}
