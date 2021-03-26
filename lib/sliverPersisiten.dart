import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;


class MySliverPersistentHeader extends StatelessWidget {
  /// Creates a sliver that varies its size when it is scrolled to the start of
  /// a viewport.
  ///
  /// The [delegate], [pinned], and [floating] arguments must not be null.
  const MySliverPersistentHeader({
    Key? key,
    required this.delegate,
    this.isScroll = true,
  }) : 
        super(key: key);

  final SliverPersistentHeaderDelegate delegate;

  final bool isScroll;

  @override
  Widget build(BuildContext context) {
    return _SliverFloatingPinnedPersistentHeader(isScroll: isScroll ,delegate: delegate);
  }

}

class _SliverFloatingPinnedPersistentHeader extends _SliverPersistentHeaderRenderObjectWidget {
  const _SliverFloatingPinnedPersistentHeader({
    Key? key,
    required bool isScroll,
    required SliverPersistentHeaderDelegate delegate,
  }) : super(
    key: key,
    delegate: delegate,
    isScroll: isScroll,
  );

  @override
  _RenderSliverPersistentHeaderForWidgetsMixin createRenderObject(BuildContext context) {
    return _RenderSliverFloatingPinnedPersistentHeaderForWidgets(
      isScroll: isScroll,
      vsync: delegate.vsync,
      snapConfiguration: delegate.snapConfiguration,
      stretchConfiguration: delegate.stretchConfiguration,
      showOnScreenConfiguration: delegate.showOnScreenConfiguration,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSliverFloatingPinnedPersistentHeaderForWidgets renderObject) {
    renderObject.vsync = delegate.vsync;
    renderObject.isScroll = isScroll;
    renderObject.snapConfiguration = delegate.snapConfiguration;
    renderObject.stretchConfiguration = delegate.stretchConfiguration;
    renderObject.showOnScreenConfiguration = delegate.showOnScreenConfiguration;
  }
}

abstract class _SliverPersistentHeaderRenderObjectWidget extends RenderObjectWidget {
  const _SliverPersistentHeaderRenderObjectWidget({
    Key? key,
    required this.isScroll,
    required this.delegate,
  }) : assert(delegate != null),
        super(key: key);

  final SliverPersistentHeaderDelegate delegate;
  final bool isScroll;

  @override
  _SliverPersistentHeaderElement createElement() => _SliverPersistentHeaderElement(this);

  @override
  _RenderSliverPersistentHeaderForWidgetsMixin createRenderObject(BuildContext context);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(
        DiagnosticsProperty<SliverPersistentHeaderDelegate>(
          'delegate',
          delegate,
        )
    );
  }
}

class _RenderSliverFloatingPinnedPersistentHeaderForWidgets extends MyRenderSliverFloatingPinnedPersistentHeader
    with _RenderSliverPersistentHeaderForWidgetsMixin {
  _RenderSliverFloatingPinnedPersistentHeaderForWidgets({
    RenderBox? child,
    required bool isScroll,
    required TickerProvider? vsync,
    FloatingHeaderSnapConfiguration? snapConfiguration,
    OverScrollHeaderStretchConfiguration? stretchConfiguration,
    PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration,
  }) : super(
    child: child,
    vsync: vsync,
    isScroll: isScroll,
    snapConfiguration: snapConfiguration,
    stretchConfiguration: stretchConfiguration,
    showOnScreenConfiguration: showOnScreenConfiguration,
  );
}

mixin _RenderSliverPersistentHeaderForWidgetsMixin on RenderSliverPersistentHeader {
  _SliverPersistentHeaderElement? _element;

  @override
  double get minExtent => _element!.widget.delegate.minExtent;

  @override
  double get maxExtent => _element!.widget.delegate.maxExtent;

  @override
  void updateChild(double shrinkOffset, bool overlapsContent) {
    assert(_element != null);
    _element!._build(shrinkOffset, overlapsContent);
  }

  @protected
  void triggerRebuild() {
    markNeedsLayout();
  }
}

class _SliverPersistentHeaderElement extends RenderObjectElement {
  _SliverPersistentHeaderElement(_SliverPersistentHeaderRenderObjectWidget widget) : super(widget);

  @override
  _SliverPersistentHeaderRenderObjectWidget get widget => super.widget as _SliverPersistentHeaderRenderObjectWidget;

  @override
  _RenderSliverPersistentHeaderForWidgetsMixin get renderObject => super.renderObject as _RenderSliverPersistentHeaderForWidgetsMixin;

  @override
  void mount(Element? parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    renderObject._element = this;
  }

  @override
  void unmount() {
    super.unmount();
    renderObject._element = null;
  }

  @override
  void update(_SliverPersistentHeaderRenderObjectWidget newWidget) {
    final _SliverPersistentHeaderRenderObjectWidget oldWidget = widget;
    super.update(newWidget);
    final SliverPersistentHeaderDelegate newDelegate = newWidget.delegate;
    final SliverPersistentHeaderDelegate oldDelegate = oldWidget.delegate;
    if (newDelegate != oldDelegate &&
        (newDelegate.runtimeType != oldDelegate.runtimeType || newDelegate.shouldRebuild(oldDelegate)))
      renderObject.triggerRebuild();
  }

  @override
  void performRebuild() {
    super.performRebuild();
    renderObject.triggerRebuild();
  }

  Element? child;

  void _build(double shrinkOffset, bool overlapsContent) {
    owner!.buildScope(this, () {
      child = updateChild(
        child,
        widget.delegate.build(
            this,
            shrinkOffset,
            overlapsContent
        ),
        null,
      );
    });
  }

  @override
  void forgetChild(Element child) {
    assert(child == this.child);
    this.child = null;
    super.forgetChild(child);
  }

  @override
  void insertRenderObjectChild(covariant RenderBox child, dynamic slot) {
    assert(renderObject.debugValidateChild(child));
    renderObject.child = child;
  }

  @override
  void moveRenderObjectChild(covariant RenderObject child, dynamic oldSlot, dynamic newSlot) {
    assert(false);
  }

  @override
  void removeRenderObjectChild(covariant RenderObject child, dynamic slot) {
    renderObject.child = null;
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    if (child != null)
      visitor(child!);
  }
}


abstract class MyRenderSliverFloatingPinnedPersistentHeader extends MyRenderSliverFloatingPersistentHeader {
  /// Creates a sliver that shrinks when it hits the start of the viewport, then
  /// stays pinned there, and grows immediately when the user reverses the
  /// scroll direction.
  MyRenderSliverFloatingPinnedPersistentHeader({
    RenderBox? child,
    bool? isScroll,
    TickerProvider? vsync,
    FloatingHeaderSnapConfiguration? snapConfiguration,
    OverScrollHeaderStretchConfiguration? stretchConfiguration,
    PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration,
  }) : super(
    child: child,
    vsync: vsync,
    isScroll: isScroll!,
    snapConfiguration: snapConfiguration,
    stretchConfiguration: stretchConfiguration,
    showOnScreenConfiguration: showOnScreenConfiguration,
  );

  @override
  double updateGeometry() {
    final double minExtent = this.minExtent;
    final double minAllowedExtent = constraints.remainingPaintExtent > minExtent ?
    minExtent :
    constraints.remainingPaintExtent;
    final double maxExtent = this.maxExtent;
    // if (constraints.scrollOffset > 300 && ) {
    //   _effectiveScrollOffset = 0;
    // }
    final double paintExtent = maxExtent - _effectiveScrollOffset!;
    final double clampedPaintExtent = paintExtent.clamp(
      minAllowedExtent,
      constraints.remainingPaintExtent,
    );
    final double layoutExtent = maxExtent - constraints.scrollOffset;
    final double stretchOffset = stretchConfiguration != null ?
    constraints.overlap.abs() :
    0.0;

    geometry = SliverGeometry(
      scrollExtent: maxExtent,
      paintOrigin: math.min(constraints.overlap, 0.0),
      paintExtent: clampedPaintExtent,
      layoutExtent: layoutExtent.clamp(0.0, clampedPaintExtent),
      maxPaintExtent: maxExtent + stretchOffset,
      maxScrollObstructionExtent: minExtent,
      hasVisualOverflow: true, // Conservatively say we do have overflow to avoid complexity.
    );
    return 0.0;
  }
}

abstract class MyRenderSliverFloatingPersistentHeader extends RenderSliverPersistentHeader {
  /// Creates a sliver that shrinks when it hits the start of the viewport, then
  /// scrolls off, and comes back immediately when the user reverses the scroll
  /// direction.
  MyRenderSliverFloatingPersistentHeader({
    RenderBox? child,
    TickerProvider? vsync,
    this.snapConfiguration,
    required this.isScroll,
    OverScrollHeaderStretchConfiguration? stretchConfiguration,
    required this.showOnScreenConfiguration,
  }) : _vsync = vsync,
        super(
        child: child,
        stretchConfiguration: stretchConfiguration,
      );

  AnimationController? _controller;
  late Animation<double> _animation;
  double? _lastActualScrollOffset;
  double? _effectiveScrollOffset;

  // Distance from our leading edge to the child's leading edge, in the axis
  // direction. Negative if we're scrolled off the top.
  double? _childPosition;

  @override
  void detach() {
    _controller?.dispose();
    _controller = null; // lazily recreated if we're reattached.
    super.detach();
  }


  /// A [TickerProvider] to use when animating the scroll position.
  TickerProvider? get vsync => _vsync;
  TickerProvider? _vsync;
  set vsync(TickerProvider? value) {
    if (value == _vsync)
      return;
    _vsync = value;
    if (value == null) {
      _controller?.dispose();
      _controller = null;
    } else {
      _controller?.resync(value);
    }
  }

  /// Defines the parameters used to snap (animate) the floating header in and
  /// out of view.
  ///
  /// If [snapConfiguration] is null then the floating header does not snap.
  ///
  /// See also:
  ///
  ///  * [RenderSliverFloatingPersistentHeader.maybeStartSnapAnimation] and
  ///    [RenderSliverFloatingPersistentHeader.maybeStopSnapAnimation], which
  ///    start or stop the floating header's animation.
  ///  * [SliverAppBar], which creates a header that can be pinned, floating,
  ///    and snapped into view via the corresponding parameters.
  FloatingHeaderSnapConfiguration? snapConfiguration;

  bool isScroll = true;

  /// {@macro flutter.rendering.PersistentHeaderShowOnScreenConfiguration}
  ///
  /// If set to null, the persistent header will delegate the `showOnScreen` call
  /// to it's parent [RenderObject].
  PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration;

  /// Updates [geometry], and returns the new value for [childMainAxisPosition].
  ///
  /// This is used by [performLayout].
  @protected
  double updateGeometry() {
    double stretchOffset = 0.0;
    if (stretchConfiguration != null && _childPosition == 0.0) {
      stretchOffset += constraints.overlap.abs();
    }
    final double maxExtent = this.maxExtent;
    final double paintExtent = maxExtent - _effectiveScrollOffset!;
    final double layoutExtent = maxExtent - constraints.scrollOffset;
    geometry = SliverGeometry(
      scrollExtent: maxExtent,
      paintOrigin: math.min(constraints.overlap, 0.0),
      paintExtent: paintExtent.clamp(0.0, constraints.remainingPaintExtent),
      layoutExtent: layoutExtent.clamp(0.0, constraints.remainingPaintExtent),
      maxPaintExtent: maxExtent + stretchOffset,
      hasVisualOverflow: true, // Conservatively say we do have overflow to avoid complexity.
    );
    return stretchOffset > 0 ? 0.0 : math.min(0.0, paintExtent - childExtent);
  }

  void _updateAnimation(Duration duration, double endValue, Curve curve) {
    assert(duration != null);
    assert(endValue != null);
    assert(curve != null);
    assert(
    vsync != null,
    'vsync must not be null if the floating header changes size animatedly.',
    );

    final AnimationController effectiveController =
    _controller ??= AnimationController(vsync: vsync!, duration: duration)
      ..addListener(() {
        if (_effectiveScrollOffset == _animation.value)
          return;
        _effectiveScrollOffset = _animation.value;
        markNeedsLayout();
      });

    _animation = effectiveController.drive(
      Tween<double>(
        begin: _effectiveScrollOffset,
        end: endValue,
      ).chain(CurveTween(curve: curve)),
    );
  }

  /// If the header isn't already fully exposed, then scroll it into view.
  void maybeStartSnapAnimation(ScrollDirection direction) {
    final FloatingHeaderSnapConfiguration? snap = snapConfiguration;
    if (snap == null)
      return;
    if (direction == ScrollDirection.forward && _effectiveScrollOffset! <= 0.0)
      return;
    if (direction == ScrollDirection.reverse && _effectiveScrollOffset! >= maxExtent)
      return;

    _updateAnimation(
      snap.duration,
      direction == ScrollDirection.forward ? 0.0 : maxExtent,
      snap.curve,
    );
    _controller?.forward(from: 0.0);
  }

  /// If a header snap animation or a [showOnScreen] expand animation is underway
  /// then stop it.
  void maybeStopSnapAnimation(ScrollDirection direction) {
    _controller?.stop();
  }

  @override
  void performLayout() {
    final SliverConstraints constraints = this.constraints;
    final double maxExtent = this.maxExtent;
    if (_lastActualScrollOffset != null && // We've laid out at least once to get an initial position, and either
        ((constraints.scrollOffset < _lastActualScrollOffset!) || // we are scrolling back, so should reveal, or
            (_effectiveScrollOffset! < maxExtent))) { // some part of it is visible, so should shrink or reveal as appropriate.
      double delta = _lastActualScrollOffset! - constraints.scrollOffset;

      final bool allowFloatingExpansion = constraints.userScrollDirection == ScrollDirection.forward;
      if (allowFloatingExpansion) {
        if (_effectiveScrollOffset! > maxExtent) // We're scrolled off-screen, but should reveal, so
          _effectiveScrollOffset = maxExtent; // pretend we're just at the limit.
      } else {
        if (delta > 0.0) // If we are trying to expand when allowFloatingExpansion is false,
          delta = 0.0; // disallow the expansion. (But allow shrinking, i.e. delta < 0.0 is fine.)
      }
      _effectiveScrollOffset = (_effectiveScrollOffset! - delta).clamp(0.0, constraints.scrollOffset);
    } else {
      _effectiveScrollOffset = constraints.scrollOffset;
    }

    if (isScroll == false) {
      _effectiveScrollOffset = 0;
    }

    final bool overlapsContent = _effectiveScrollOffset! < constraints.scrollOffset;

    layoutChild(
      _effectiveScrollOffset!,
      maxExtent,
      overlapsContent: overlapsContent,
    );
    _childPosition = updateGeometry();
    _lastActualScrollOffset = constraints.scrollOffset;
  }

  @override
  void showOnScreen({
    RenderObject? descendant,
    Rect? rect,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
  }) {
    final PersistentHeaderShowOnScreenConfiguration? showOnScreen = showOnScreenConfiguration;
    if (showOnScreen == null)
      return super.showOnScreen(descendant: descendant, rect: rect, duration: duration, curve: curve);

    assert(child != null || descendant == null);
    // We prefer the child's coordinate space (instead of the sliver's) because
    // it's easier for us to convert the target rect into target extents: when
    // the sliver is sitting above the leading edge (not possible with pinned
    // headers), the leading edge of the sliver and the leading edge of the child
    // will not be aligned. The only exception is when child is null (and thus
    // descendant == null).
    final Rect? childBounds = descendant != null
        ? MatrixUtils.transformRect(descendant.getTransformTo(child), rect ?? descendant.paintBounds)
        : rect;

    double targetExtent;
    Rect? targetRect;
    switch (applyGrowthDirectionToAxisDirection(constraints.axisDirection, constraints.growthDirection)) {
      case AxisDirection.up:
        targetExtent = childExtent - (childBounds?.top ?? 0);
        targetRect = _trim(childBounds, bottom: childExtent);
        break;
      case AxisDirection.right:
        targetExtent = childBounds?.right ?? childExtent;
        targetRect = _trim(childBounds, left: 0);
        break;
      case AxisDirection.down:
        targetExtent = childBounds?.bottom ?? childExtent;
        targetRect = _trim(childBounds, top: 0);
        break;
      case AxisDirection.left:
        targetExtent = childExtent - (childBounds?.left ?? 0);
        targetRect = _trim(childBounds, right: childExtent);
        break;
    }

    // A stretch header can have a bigger childExtent than maxExtent.
    final double effectiveMaxExtent = math.max(childExtent, maxExtent);

    targetExtent = targetExtent.clamp(
      showOnScreen.minShowOnScreenExtent,
      showOnScreen.maxShowOnScreenExtent,
    )
    // Clamp the value back to the valid range after applying additional
    // constriants. Contracting is not allowed.
        .clamp(childExtent, effectiveMaxExtent);

    // Expands the header if needed, with animation.
    if (targetExtent > childExtent) {
      final double targetScrollOffset = maxExtent - targetExtent;
      assert(
      vsync != null,
      'vsync must not be null if the floating header changes size animatedly.',
      );
      _updateAnimation(duration, targetScrollOffset, curve);
      _controller?.forward(from: 0.0);
    }

    super.showOnScreen(
      descendant: descendant == null ? this : child,
      rect: targetRect,
      duration: duration,
      curve: curve,
    );
  }

  @override
  double childMainAxisPosition(RenderBox child) {
    assert(child == this.child);
    return _childPosition ?? 0.0;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('effective scroll offset', _effectiveScrollOffset));
  }
}

Rect? _trim(Rect? original, {
  double top = -double.infinity,
  double right = double.infinity,
  double bottom = double.infinity,
  double left = -double.infinity,
}) => original?.intersect(Rect.fromLTRB(left, top, right, bottom));




