// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
//
// class DraggableBox extends SingleChildRenderObjectWidget {
//   const DraggableBox({
//     super.key,
//     required this.widget,
//   });
//
//   final Widget widget;
//
//   @override
//   DraggableBoxRenderObject createRenderObject(BuildContext context) {
//     return DraggableBoxRenderObject(
//       widget: widget,
//     );
//   }
// }
//
// class DraggableBoxRenderObject extends RenderBox {
//   DraggableBoxRenderObject({
//     required this.widget,
//   });
//
//   Widget widget;
//
//
//
//   Offset? startPosition;
//   Offset? position;
//   bool isDragging = false;
//
//   @override
//   void handleEvent(PointerEvent event, HitTestEntry entry) {
//     if (event is PointerDownEvent) {
//       isDragging = true;
//     } else if (event is PointerMoveEvent && isDragging) {
//       position = event.position;
//       markNeedsPaint();
//     } else if (event is PointerUpEvent || event is PointerCancelEvent) {
//       isDragging = false;
//     }
//   }
//
//   @override
//   bool hitTestSelf(Offset position) {
//     final minX = (this.position?.dx ?? 0) - width / 2;
//     final maxX = (this.position?.dx ?? 0) + width / 2;
//
//     final minY = (this.position?.dy ?? 0) - height / 2;
//     final maxY = (this.position?.dy ?? 0) + height / 2;
//
//     final dxPositionOfThePointerOnTheWholeScreen =
//         position.dx + (startPosition?.dx ?? 0);
//     final dyPositionOfThePointerOnTheWholeScreen =
//         position.dy + (startPosition?.dy ?? 0);
//
//     final isDxAcceptable = dxPositionOfThePointerOnTheWholeScreen > minX &&
//         dxPositionOfThePointerOnTheWholeScreen < maxX;
//     final isDyAcceptable = dyPositionOfThePointerOnTheWholeScreen > minY &&
//         dyPositionOfThePointerOnTheWholeScreen < maxY;
//
//     return isDxAcceptable && isDyAcceptable;
//   }
//
//   @override
//   void performLayout() {
//     size = constraints.biggest;
//   }
//
//   @override
//   void paint(PaintingContext context, Offset offset) {
//     position ??= offset;
//     startPosition ??= offset;
//     context.canvas.drawRect(
//       Rect.fromCenter(
//         center: Offset(
//           position?.dx ?? offset.dx + width / 2,
//           position?.dy ?? offset.dy + height / 2,
//         ),
//         height: height,
//         width: width,
//       ),
//       Paint()..color = color,
//     );
//   }
// }