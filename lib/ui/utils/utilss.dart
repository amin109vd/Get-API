import 'package:flutter/material.dart';

extension Utils on num {
  SizedBox get toHeight => SizedBox(
        height: toDouble(),
      );
  SizedBox get toWidth => SizedBox(
        width: toDouble(),
      );
}
