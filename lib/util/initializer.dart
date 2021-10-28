import 'package:flutter/material.dart';

class InitializerWrapper extends StatefulWidget {
  const InitializerWrapper(
      {Key? key, required this.onInit, required this.child})
      : super(key: key);
  final Function onInit;
  final Widget child;
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<InitializerWrapper> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
