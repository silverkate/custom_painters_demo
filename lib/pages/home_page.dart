import 'package:custom_painters_demo/pages/draggable_container_page.dart';
import 'package:custom_painters_demo/pages/draggable_widget_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Painters Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              onPressed: () => _openDraggableContainer(context),
              child: const Text('Open DraggableContainer'),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () => _openDraggableWidget(context),
              child: const Text('Open DraggableWidget'),
            ),
          ),
        ],
      ),
    );
  }

  void _openDraggableContainer(BuildContext context) {
    Navigator.of(context).pushNamed(DraggableContainerPage.route);
  }

  void _openDraggableWidget(BuildContext context) {
    Navigator.of(context).pushNamed(DraggableWidgetPage.route);
  }
}
