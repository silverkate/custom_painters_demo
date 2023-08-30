import 'package:custom_painters_demo/widgets/index.dart';
import 'package:flutter/material.dart';

class DraggableContainerPage extends StatelessWidget {
  const DraggableContainerPage({super.key});

  static const route = '/draggableContainer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DraggableContainerPage')),
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
