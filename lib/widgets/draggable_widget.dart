import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DraggableWidget extends SingleChildRenderObjectWidget {
  const DraggableWidget({
    super.key,
    required Widget child,
  }) : super(child: child);

  @override
  DraggableWidgetRenderObject createRenderObject(BuildContext context) {
    return DraggableWidgetRenderObject();
  }
}

class DraggableWidgetRenderObject extends RenderProxyBox {
  DraggableWidgetRenderObject({
    RenderBox? child,
  }) : super(child);

  Offset? _position;
  Matrix4? _transform;
  bool _isDragging = false;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child != null) {
      final Size childSize = child!.getDryLayout(const BoxConstraints());

      // During [RenderObject.debugCheckingIntrinsics] a child that doesn't
      // support dry layout may provide us with an invalid size that triggers
      // assertions if we try to work with it. Instead of throwing, we bail
      // out early in that case.
      bool invalidChildSize = false;
      assert(() {
        if (RenderObject.debugCheckingIntrinsics &&
            childSize.width * childSize.height == 0.0) {
          invalidChildSize = true;
        }
        return true;
      }());
      if (invalidChildSize) {
        assert(debugCannotComputeDryLayout(
          reason: 'Child provided invalid size of $childSize.',
        ));
        return Size.zero;
      }

      return constraints
          .constrainSizeAndAttemptToPreserveAspectRatio(childSize);
    } else {
      return constraints.smallest;
    }
  }

  @override
  void performLayout() {
    if (child != null) {
      child!.layout(const BoxConstraints(), parentUsesSize: true);
      size = constraints.biggest;
      _clearPaintData();
    } else {
      size = constraints.biggest;
    }
  }

  void _clearPaintData() {
    _transform = null;
  }

  void _updatePaintData() {
    if (_transform != null) {
      return;
    }

    if (child == null) {
      _transform = Matrix4.identity();
    } else {
      final Size childSize = child!.size;
      final FittedSizes sizes = applyBoxFit(BoxFit.contain, childSize, size);
      final Rect sourceRect =
          Alignment.center.inscribe(sizes.source, Offset.zero & childSize);
      final Rect destinationRect =
          Alignment.center.inscribe(sizes.destination, Offset.zero & size);
      _transform = Matrix4.translationValues(
        destinationRect.left + destinationRect.width / 2 - sourceRect.width / 2,
        destinationRect.top +
            destinationRect.height / 2 -
            sourceRect.height / 2,
        0.0,
      )..translate(-sourceRect.left, -sourceRect.top);
    }
  }

  TransformLayer? _paintChildWithTransform(
      PaintingContext context, Offset offset) {
    final Offset? childOffset = MatrixUtils.getAsTranslation(_transform!);
    if (childOffset == null) {
      return context.pushTransform(
        needsCompositing,
        offset,
        _transform!,
        super.paint,
        oldLayer: layer is TransformLayer ? layer! as TransformLayer : null,
      );
    } else {
      super.paint(context, offset + childOffset);
    }
    return null;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _position ??= offset;
    if (child == null || size.isEmpty || child!.size.isEmpty) {
      return;
    }
    _updatePaintData();
    layer = _paintChildWithTransform(context, _position ?? offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return true;
  }

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    if (event is PointerDownEvent) {
      _isDragging = true;
    } else if (event is PointerMoveEvent && _isDragging) {
      _position = event.position; // - initPosition;
      markNeedsPaint();
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      _isDragging = false;
    }
  }

  @override
  bool paintsChild(RenderBox child) {
    assert(child.parent == this);
    return !size.isEmpty && !child.size.isEmpty;
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    if (!paintsChild(child)) {
      transform.setZero();
    } else {
      _updatePaintData();
      transform.multiply(_transform!);
    }
  }
}
