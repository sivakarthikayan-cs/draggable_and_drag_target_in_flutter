import 'package:flutter/material.dart';

class DragContainer extends StatefulWidget {
  const DragContainer({super.key});

  @override
  State<DragContainer> createState() => _DragContainerState();
}

class _DragContainerState extends State<DragContainer> {
  Offset currentPosition = const Offset(0, 0);
  double _scale = 1;
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: currentPosition,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            currentPosition += details.delta;
          });
        },
        onPanStart: (_) {
          setState(() {
            isDragging = true;
          });
        },
        onPanEnd: (_) {
          setState(() {
            isDragging = false;
          });
        },
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: _scale, end: _scale),
          duration: const Duration(milliseconds: 300),
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: MouseRegion(
                cursor: isDragging
                    ? SystemMouseCursors.grabbing
                    : SystemMouseCursors.grab,
                onEnter: (event) {
                  setState(() {
                    _scale = 1.1;
                  });
                },
                onExit: (event) {
                  setState(() {
                    _scale = 1.0;
                  });
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text(
                      isDragging ? "Drop me anywhere" : "Drag me",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
