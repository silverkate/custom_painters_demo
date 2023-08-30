import 'package:custom_painters_demo/widgets/index.dart';
import 'package:flutter/material.dart';

class DraggableWidgetPage extends StatelessWidget {
  const DraggableWidgetPage({super.key});

  static const route = '/draggableWidget';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DraggableWidgetPage')),
      body: const Center(
        child: DraggableBox(
          height: 40,
          width: 24,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
