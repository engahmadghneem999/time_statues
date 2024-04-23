import 'package:flutter/material.dart';

import '../../../../core/constant/color.dart';

class DividerVertical extends StatelessWidget {
  const DividerVertical({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.fromLTRB(16, 6, 6, 6),
      decoration: BoxDecoration(
        color:color,
        borderRadius: BorderRadius.circular(8),
      ),
      width: 10,
    );
  }
}
