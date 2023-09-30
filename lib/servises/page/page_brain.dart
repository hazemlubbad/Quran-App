import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../network_connectivity.dart';

class PageBrain {
  bool isPined = false;
  late PageController _controller;
  double progress = 0;
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  ConnectivityResult? connectivityResult;

  NetworkConnectivity get networkConnectivity => _networkConnectivity;

  setProgress() {}

  PageController getController() {
    return _controller;
  }

  void setPageController(PageController controller) {
    _controller = controller;
  }

  void shiftPined() {
    isPined = !isPined;
  }

  bool getPined() {
    return isPined;
  }

  void testConnectivity() async {
    await _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _source = source;
      connectivityResult = _source.keys.toList()[0];
    });
  }

  void animateTo(int page) {
    _controller.animateToPage(page,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void dispose() {
    _controller.dispose();
    _networkConnectivity.disposeStream();
  }
}
