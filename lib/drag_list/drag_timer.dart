import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DragTimer extends StatefulWidget {
  const DragTimer({Key? key}) : super(key: key);

  @override
  State<DragTimer> createState() => _DragTimerState();
}

class _DragTimerState extends State<DragTimer> {
  Offset currentPosition = const Offset(0, 0);
  late int remainingSeconds = 20;
  bool isDragging = false;
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: currentPosition,
      child: TweenAnimationBuilder<Duration>(
        key: ValueKey<int>(remainingSeconds),
        duration: Duration(seconds: remainingSeconds.abs()),
        onEnd: () {
          setState(() {
            remainingSeconds = 0;
          });
        },
        tween: Tween(
            begin: Duration(seconds: remainingSeconds), end: Duration.zero),
        builder: (BuildContext context, Duration value, Widget? child) {
          int minutes = value.inMinutes % 60;
          int hours = value.inHours;
          int seconds = value.inSeconds % 60;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.access_time_outlined,
              ),
              RichText(
                overflow: TextOverflow.visible,
                maxLines: 1,
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text:
                          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                    ),
                    const TextSpan(
                      text: "Hrs",
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      remainingSeconds = remainingSeconds + 1;
                    });
                  },
                  icon: const Icon(CupertinoIcons.plus)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      remainingSeconds = remainingSeconds - 1;
                    });
                  },
                  icon: const Icon(CupertinoIcons.minus)),
              GestureDetector(
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
                  child: MouseRegion(
                      cursor: isDragging
                          ? SystemMouseCursors.grabbing
                          : SystemMouseCursors.grab,
                      child: const Icon(Icons.drag_indicator)))
            ],
          );
        },
      ),
    );
  }
}
