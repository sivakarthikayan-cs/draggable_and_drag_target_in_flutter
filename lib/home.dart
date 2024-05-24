import 'package:flutter/material.dart';

import 'drag_list/drag_container.dart';
import 'drag_list/drag_timer.dart';
import 'drag_list/draggable.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isDragging = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: MouseRegion(
        cursor: _isDragging
            ? SystemMouseCursors.grabbing
            : SystemMouseCursors.contextMenu,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const DragContainer(),
              const SizedBox(height: 50),
              const DragTimer(),
              const SizedBox(height: 50),
              DragDropExample(
                isDragging: (isDragging) {
                  setState(() {
                    _isDragging = isDragging;
                  });
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    ));
  }
}
