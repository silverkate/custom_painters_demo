import 'package:custom_painters_demo/widgets/index.dart';
import 'package:flutter/material.dart';

class DraggableWidgetPage extends StatelessWidget {
  const DraggableWidgetPage({super.key});

  static const route = '/draggableWidget';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DraggableWidgetPage')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: DraggableWidget(
            child: Container(
              width: 100,
              height: 100,
              color: Colors.teal,
              child: const Center(
                child: Text(
                  'Text',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
