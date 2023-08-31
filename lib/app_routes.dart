import 'package:custom_painters_demo/pages/draggable_container_page.dart';
import 'package:custom_painters_demo/pages/draggable_widget_page.dart';
import 'package:flutter/material.dart';

final appRoutes = <String, WidgetBuilder>{
  DraggableContainerPage.route: (context) => const DraggableContainerPage(),
  DraggableWidgetPage.route: (context) => const DraggableWidgetPage(),
};
