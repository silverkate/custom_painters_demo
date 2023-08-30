import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DraggableBox extends LeafRenderObjectWidget {
  const DraggableBox({
    super.key,
    required this.height,
    required this.width,
    required this.color,
  });

  final double height;
  final double width;
  final Color color;

  @override
  DraggableBoxRenderObject createRenderObject(BuildContext context) {
    return DraggableBoxRenderObject(
      height: height,
      width: width,
      color: color,
    );
  }
}

class DraggableBoxRenderObject extends RenderBox {
  DraggableBoxRenderObject({
    required this.height,
    required this.width,
    required this.color,
  });

  double height;
  double width;
  Color color;

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
    final minX = (this.position?.dx ?? 0) - width / 2;
    final maxX = (this.position?.dx ?? 0) + width / 2;

    final minY = (this.position?.dy ?? 0) - height / 2;
    final maxY = (this.position?.dy ?? 0) + height / 2;

    final dxPositionOfThePointerOnTheWholeScreen =
        position.dx + (startPosition?.dx ?? 0);
    final dyPositionOfThePointerOnTheWholeScreen =
        position.dy + (startPosition?.dy ?? 0);

    final isDxAcceptable = dxPositionOfThePointerOnTheWholeScreen > minX &&
        dxPositionOfThePointerOnTheWholeScreen < maxX;
    final isDyAcceptable = dyPositionOfThePointerOnTheWholeScreen > minY &&
        dyPositionOfThePointerOnTheWholeScreen < maxY;

    return isDxAcceptable && isDyAcceptable;
  }

  @override
  bool debugHandleEvent(
    PointerEvent event,
    HitTestEntry<HitTestTarget> entry,
  ) {
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
    context.canvas.drawRect(
      Rect.fromCenter(
        center: Offset(
          position?.dx ?? offset.dx + width / 2,
          position?.dy ?? offset.dy + height / 2,
        ),
        height: height,
        width: width,
      ),
      Paint()..color = color,
    );
  }
}