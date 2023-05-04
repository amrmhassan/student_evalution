// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/screen_wrapper.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

class TestScreen extends StatelessWidget {
  static const String routeName = '/TestScreen';
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        backgroundColor: colorTheme.kBlueColor,
        body: Column(
          children: [
            WaveContainer(),
          ],
        ));
  }
}

class WaveContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: CustomPaint(
        painter: WavePainter(),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.5)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.9, size.height * 0.6, size.width * 0.8,
          size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.7, size.height * 0.4, size.width * 0.6,
          size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.6, size.width * 0.4,
          size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.4, size.width * 0.2,
          size.height * 0.5)
      ..quadraticBezierTo(
          size.width * 0.1, size.height * 0.6, 0, size.height * 0.5)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
