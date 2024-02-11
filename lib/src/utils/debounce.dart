import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  final int milliseconds;

   Debounce({required this.milliseconds});

  late Timer timer;

  void run(VoidCallback action) {
    timer.cancel();
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void close() {
    timer.cancel();
  }
}
