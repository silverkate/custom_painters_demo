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

  Offset? _position;
  Offset? _initialConstraintsOffset;

  bool _isDragging = false;
  Offset _tapPosition = const Offset(0, 0);

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    if (event is PointerDownEvent) {
      final tmpInitPosition = Offset(event.position.dx, event.position.dy);

      final maxX = (_position?.dx ?? 0) + width;
      final maxY = (_position?.dy ?? 0) + height;

      final qx = maxX - tmpInitPosition.dx;
      final qy = maxY - tmpInitPosition.dy;

      _tapPosition = Offset(width - qx, height - qy);

      _isDragging = true;
    } else if (event is PointerMoveEvent && _isDragging) {
      _position = event.position - _tapPosition;
      markNeedsPaint();
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      _isDragging = false;
    }
  }

  @override
  bool hitTestSelf(Offset position) {
    final minX = (_position?.dx ?? 0);
    final maxX = (_position?.dx ?? 0) + width;

    final minY = (_position?.dy ?? 0);
    final maxY = (_position?.dy ?? 0) + height;

    final dxPositionOfThePointerOnTheWholeScreen =
        position.dx + (_initialConstraintsOffset?.dx ?? 0);
    final dyPositionOfThePointerOnTheWholeScreen =
        position.dy + (_initialConstraintsOffset?.dy ?? 0);

    final isDxAcceptable = dxPositionOfThePointerOnTheWholeScreen > minX &&
        dxPositionOfThePointerOnTheWholeScreen < maxX;
    final isDyAcceptable = dyPositionOfThePointerOnTheWholeScreen > minY &&
        dyPositionOfThePointerOnTheWholeScreen < maxY;

    return isDxAcceptable && isDyAcceptable;
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _position ??= Offset(
      (_position?.dx ?? offset.dx) + width / 2,
      (_position?.dy ?? offset.dy) + height / 2,
    );
    _initialConstraintsOffset ??= Offset(
      offset.dx,
      offset.dy,
    );
    context.canvas.drawRect(
      Rect.fromCenter(
        center: Offset(
          (_position?.dx ?? offset.dx) + width / 2,
          (_position?.dy ?? offset.dy) + height / 2,
        ),
        height: height,
        width: width,
      ),
      Paint()..color = color,
    );
  }
}
