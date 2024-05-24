import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class DragDropExample extends StatefulWidget {
  final DraggingCallback isDragging;
  const DragDropExample({
    Key? key,
    required this.isDragging,
  }) : super(key: key);

  @override
  State<DragDropExample> createState() => _DragDropExampleState();
}

typedef DraggingCallback = void Function(bool isDragging);

class _DragDropExampleState extends State<DragDropExample> {
  bool _isDropped = false;
  bool isDragging = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            cursor: isDragging
                ? SystemMouseCursors.grabbing
                : SystemMouseCursors.grab,
            child: Draggable(
              onDragStarted: () {
                widget.isDragging(true);
                setState(() {
                  isDragging = true;
                });
              },
              onDragEnd: (_) {
                widget.isDragging(false);
                setState(() {
                  isDragging = false;
                });
              },
              onDragUpdate: (_) {
                widget.isDragging(true);
                setState(() {
                  isDragging = true;
                });
              },
              data: 'Flutter',
              feedback: const DraggableWidget(),
              childWhenDragging: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(12)),
              ),
              onDragCompleted: () {
                setState(() {
                  _isDropped = true;
                });
              },
              child: _isDropped ? const SizedBox() : const DraggableWidget(),
            ),
          ),
          const SizedBox(height: 20),
          DragTarget(
            builder: (BuildContext context, List<dynamic> accepted,
                List<dynamic> rejected) {
              return DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: const [6, 3],
                color: Colors.blue,
                strokeWidth: 2,
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: const Text('Drop here'),
                ),
              );
            },
            onAccept: (data) {
              setState(() {
                _isDropped = true;
              });
            },
          ),
        ],
      ),
    );
  }
}

class DraggableWidget extends StatelessWidget {
  const DraggableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(12)),
      alignment: Alignment.center,
      child: const Text(
        'Drag me',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
