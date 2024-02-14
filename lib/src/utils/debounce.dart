import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  final int milliseconds;

  Debounce({required this.milliseconds});

  Timer? _timer;

  void run(VoidCallback action) {
    close();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void close() {    
    if (_timer != null) {
      _timer!.cancel();
    }
  }
}
