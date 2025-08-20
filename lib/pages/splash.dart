import 'package:flutter/material.dart';

class PageSplash extends StatelessWidget {
  const PageSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/splash/splash_image.png", fit: BoxFit.cover);
  }
}
