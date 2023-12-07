import 'package:flutter/material.dart';
import 'package:ios_style_slide_to_answer/slide_to_answer_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slide To Answer Demo',
      theme: ThemeData(),
      home: const SlideToAnserView(),
    );
  }
}
