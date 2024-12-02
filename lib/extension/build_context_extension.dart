import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void navigateToscreen(Widget screen, {bool isreplace = false}) {
    if (isreplace) {
      Navigator.of(this).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => screen), (Route) => false);
    } else {
      Navigator.of(this).push(MaterialPageRoute(builder: (_) => screen));
    }
  }

  double getHeight(double percentage) {
    return MediaQuery.of(this).size.height * percentage;
  }

  double getwidth(double percentage) {
    return MediaQuery.of(this).size.width * percentage;
  }
}
