import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  const SquareTile({
    required this.imagePath,
    super.key,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        imagePath,
        height: 50,
      ),
    );
  }
}
