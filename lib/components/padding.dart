import 'package:flutter/cupertino.dart';

class padding extends StatelessWidget {
  final Widget? child;
  const padding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}
