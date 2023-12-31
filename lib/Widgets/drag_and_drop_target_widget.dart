
import 'package:flutter/material.dart';

class DragAndDropTarget extends StatelessWidget {
  final double minHeight;
  final double widthFactor;
  final double heightFactor;

  const DragAndDropTarget({
    super.key,
    this.minHeight = 100,
    this.widthFactor = 0.9, // 50% of the parent's width
    this.heightFactor = 0.9, // 10% of the parent's height
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: minHeight,
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 0.9,
          child: _buildContent()
        ),
      )
    );
  }

  Widget _buildContent() {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Center(
        child: Text(
          "Drop folders here.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}