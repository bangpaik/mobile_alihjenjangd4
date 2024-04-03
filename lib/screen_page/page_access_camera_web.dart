import 'package:flutter/material.dart';


class PageAccessCameraWeb extends StatefulWidget {
  const PageAccessCameraWeb({super.key});

  @override
  State<PageAccessCameraWeb> createState() => _PageAccessCameraWebState();
}

class _PageAccessCameraWebState extends State<PageAccessCameraWeb> {
  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.ltr,
      child: Text('Testing... Look at the console output for results!'),
    );
  }
}
