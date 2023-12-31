
import 'package:flutter/material.dart';

class DragAndDropTarget extends StatelessWidget {
  const DragAndDropTarget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const FractionallySizedBox(
        widthFactor: .75,
        heightFactor: .15,
        child: ColoredBox(
          color: Colors.lightBlue,
          child: Center(
            child: Text(
              "Drop folders here.",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}