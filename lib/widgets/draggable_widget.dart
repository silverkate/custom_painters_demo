import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DraggableWidget extends SingleChildRenderObjectWidget {
  const DraggableWidget({
    super.key,
    super.child,
  });

  @override
  DraggableWidgetRenderObject createRenderObject(BuildContext context) =>
      DraggableWidgetRenderObject();
}

class DraggableWidgetRenderObject extends RenderProxyBox {
  DraggableWidgetRenderObject();

  Offset? startPosition;
  Offset? position;
  bool isDragging = false;

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    if (event is PointerDownEvent) {
      isDragging = true;
    } else if (event is PointerMoveEvent && isDragging) {
      position = event.position;
      markNeedsPaint();
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      isDragging = false;
    }
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    position ??= offset;
    startPosition ??= offset;

    if (child != null) {
      context.paintChild(child!, position ?? offset);
    }
  }
}
