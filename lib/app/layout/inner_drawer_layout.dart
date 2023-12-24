// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

typedef InnerDrawerCallback = void Function(bool isOpened);

typedef InnerDragUpdateCallback = void Function(
    double value, InnerDrawerDirection? direction);

enum InnerDrawerDirection {
  start,
  end,
}

enum InnerDrawerAnimation {
  static,
  linear,
  quadratic,
}

const double _kWidth = 400;
const double _kMinFlingVelocity = 365.0;
const double _kEdgeDragWidth = 20.0;
const Duration _kBaseSettleDuration = Duration(milliseconds: 246);

class InnerDrawerLayout extends StatefulWidget {
  const InnerDrawerLayout(
      {GlobalKey? key,
      this.leftChild,
      this.rightChild,
      required this.scaffold,
      this.offset = const IDOffset.horizontal(0.4),
      this.scale = const IDOffset.horizontal(1),
      this.proportionalChildArea = true,
      this.borderRadius = 0,
      this.onTapClose = false,
      this.tapScaffoldEnabled = false,
      this.swipe = true,
      this.swipeChild = false,
      this.duration,
      this.velocity = 1,
      this.boxShadow,
      this.colorTransitionChild,
      this.colorTransitionScaffold,
      this.leftAnimationType = InnerDrawerAnimation.static,
      this.rightAnimationType = InnerDrawerAnimation.static,
      this.backgroundDecoration,
      this.innerDrawerCallback,
      this.onDragUpdate})
      : assert(leftChild != null || rightChild != null),
        super(key: key);

  final Widget? leftChild;

  final Widget? rightChild;

  final Widget scaffold;

  final IDOffset offset;

  final IDOffset scale;

  final bool proportionalChildArea;

  final double borderRadius;

  final bool tapScaffoldEnabled;

  final bool onTapClose;

  final bool swipe;

  final bool swipeChild;

  final Duration? duration;

  final double velocity;

  final List<BoxShadow>? boxShadow;

  final Color? colorTransitionChild;

  final Color? colorTransitionScaffold;

  final InnerDrawerAnimation leftAnimationType;

  final InnerDrawerAnimation rightAnimationType;

  final Decoration? backgroundDecoration;

  final InnerDrawerCallback? innerDrawerCallback;

  final InnerDragUpdateCallback? onDragUpdate;

  @override
  InnerDrawerState createState() => InnerDrawerState();
}

class InnerDrawerState extends State<InnerDrawerLayout>
    with SingleTickerProviderStateMixin {
  ColorTween _colorTransitionChild =
      ColorTween(begin: Colors.transparent, end: Colors.black54);
  ColorTween _colorTransitionScaffold =
      ColorTween(begin: Colors.black54, end: Colors.transparent);

  double _initWidth = _kWidth;
  Orientation _orientation = Orientation.portrait;
  InnerDrawerDirection? _position;

  @override
  void initState() {
    _position = _leftChild != null
        ? InnerDrawerDirection.start
        : InnerDrawerDirection.end;

    _controller = AnimationController(
        value: 1,
        duration: widget.duration ?? _kBaseSettleDuration,
        vsync: this)
      ..addListener(_animationChanged)
      ..addStatusListener(_animationStatusChanged);
    super.initState();
  }

  @override
  void dispose() {
    _historyEntry?.remove();
    _controller.dispose();
    _focusScopeNode.dispose();
    super.dispose();
  }

  void _animationChanged() {
    setState(() {});
    if (widget.colorTransitionChild != null) {
      _colorTransitionChild = ColorTween(
          begin: widget.colorTransitionChild!.withOpacity(0.0),
          end: widget.colorTransitionChild);
    }

    if (widget.colorTransitionScaffold != null) {
      _colorTransitionScaffold = ColorTween(
          begin: widget.colorTransitionScaffold,
          end: widget.colorTransitionScaffold!.withOpacity(0.0));
    }

    if (widget.onDragUpdate != null && _controller.value < 1) {
      widget.onDragUpdate!((1 - _controller.value), _position);
    }
  }

  LocalHistoryEntry? _historyEntry;
  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  void _ensureHistoryEntry() {
    if (_historyEntry == null) {
      final ModalRoute<dynamic>? route = ModalRoute.of(context);
      if (route != null) {
        _historyEntry = LocalHistoryEntry(onRemove: _handleHistoryEntryRemoved);
        route.addLocalHistoryEntry(_historyEntry!);
        FocusScope.of(context).setFirstFocus(_focusScopeNode);
      }
    }
  }

  void _animationStatusChanged(AnimationStatus status) {
    final bool opened = _controller.value < 0.5 ? true : false;

    switch (status) {
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.forward:
        break;
      case AnimationStatus.dismissed:
        if (_previouslyOpened != opened) {
          _previouslyOpened = opened;
          if (widget.innerDrawerCallback != null) {
            widget.innerDrawerCallback!(opened);
          }
        }
        _ensureHistoryEntry();
        break;
      case AnimationStatus.completed:
        if (_previouslyOpened != opened) {
          _previouslyOpened = opened;
          if (widget.innerDrawerCallback != null) {
            widget.innerDrawerCallback!(opened);
          }
        }
        _historyEntry?.remove();
        _historyEntry = null;
    }
  }

  void _handleHistoryEntryRemoved() {
    _historyEntry = null;
    close();
  }

  late AnimationController _controller;

  void _handleDragDown(DragDownDetails details) {
    _controller.stop();
  }

  final GlobalKey _drawerKey = GlobalKey();

  double get _width {
    return _initWidth;
  }

  double get _velocity {
    return widget.velocity;
  }

  void _updateWidth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? box =
          _drawerKey.currentContext?.findRenderObject() as RenderBox?;

      if (box != null && box.hasSize && box.size.width > 300) {
        setState(() {
          _initWidth = box.size.width;
        });
      }
    });
  }

  bool _previouslyOpened = false;

  void _move(DragUpdateDetails details) {
    double delta = details.primaryDelta! / _width;

    if (delta > 0 && _controller.value == 1 && _leftChild != null) {
      _position = InnerDrawerDirection.start;
    } else if (delta < 0 && _controller.value == 1 && _rightChild != null)
      _position = InnerDrawerDirection.end;

    double offset = _position == InnerDrawerDirection.start
        ? widget.offset.left
        : widget.offset.right;

    double ee = 1;
    if (offset <= 0.2) {
      ee = 1.7;
    } else if (offset <= 0.4)
      ee = 1.2;
    else if (offset <= 0.6) ee = 1.05;

    offset = 1 - (pow(offset / ee, 1 / 2) as double);

    switch (_position) {
      case InnerDrawerDirection.end:
        break;
      case InnerDrawerDirection.start:
        delta = -delta;
        break;
      case null:
    }
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        _controller.value -= delta + (delta * offset);
        break;
      case TextDirection.ltr:
        _controller.value += delta + (delta * offset);
        break;
    }

    final bool opened = _controller.value < 0.5 ? true : false;
    if (opened != _previouslyOpened && widget.innerDrawerCallback != null) {
      widget.innerDrawerCallback!(opened);
    }
    _previouslyOpened = opened;
  }

  void _settle(DragEndDetails details) {
    if (_controller.isDismissed) return;
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity =
          (details.velocity.pixelsPerSecond.dx + _velocity) / _width;

      switch (_position) {
        case InnerDrawerDirection.end:
          break;
        case InnerDrawerDirection.start:
          visualVelocity = -visualVelocity;
          break;
        case null:
      }
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _controller.fling(velocity: -visualVelocity);
          break;
        case TextDirection.ltr:
          _controller.fling(velocity: visualVelocity);
          break;
      }
    } else if (_controller.value < 0.5) {
      open();
    } else {
      close();
    }
  }

  void open({InnerDrawerDirection? direction}) {
    if (direction != null) _position = direction;
    _controller.fling(velocity: -_velocity);
  }

  void close({InnerDrawerDirection? direction}) {
    if (direction != null) _position = direction;
    _controller.fling(velocity: _velocity);
  }

  void toggle({InnerDrawerDirection? direction}) {
    if (_previouslyOpened) {
      close(direction: direction);
    } else {
      open(direction: direction);
    }
  }

  final GlobalKey _gestureDetectorKey = GlobalKey();

  AlignmentDirectional? get _drawerOuterAlignment {
    switch (_position) {
      case InnerDrawerDirection.start:
        return AlignmentDirectional.centerEnd;
      case InnerDrawerDirection.end:
        return AlignmentDirectional.centerStart;
      case null:
    }
    return null;
  }

  AlignmentDirectional? get _drawerInnerAlignment {
    switch (_position) {
      case InnerDrawerDirection.start:
        return AlignmentDirectional.centerStart;
      case InnerDrawerDirection.end:
        return AlignmentDirectional.centerEnd;
      case null:
    }
    return null;
  }

  InnerDrawerAnimation get _animationType {
    return _position == InnerDrawerDirection.start
        ? widget.leftAnimationType
        : widget.rightAnimationType;
  }

  double get _scaleFactor {
    return _position == InnerDrawerDirection.start
        ? widget.scale.left
        : widget.scale.right;
  }

  double get _offset {
    return _position == InnerDrawerDirection.start
        ? widget.offset.left
        : widget.offset.right;
  }

  double get _widthWithOffset {
    return (_width / 2) - (_width / 2) * _offset;
  }

  bool get _swipe {
    return widget.swipe;
  }

  bool get _swipeChild {
    return widget.swipeChild;
  }

  Widget _scaffold() {
    assert(widget.borderRadius >= 0);

    final Widget? invC = _invisibleCover();

    final Widget scaffoldChild = Stack(
      children: <Widget>[
        widget.scaffold,
        if (invC != null) invC,
      ].whereType<Widget>().toList(),
    );

    Widget container = Container(
        key: _drawerKey,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              widget.borderRadius * (1 - _controller.value),
            ),
          ),
          boxShadow: widget.boxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 5,
                )
              ],
        ),
        child: widget.borderRadius != 0
            ? ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    widget.borderRadius * (1 - _controller.value),
                  ),
                ),
                child: scaffoldChild)
            : scaffoldChild);

    if (_scaleFactor < 1) {
      container = Transform.scale(
        alignment: _drawerInnerAlignment,
        scale: ((1 - _scaleFactor) * _controller.value) + _scaleFactor,
        child: container,
      );
    }

    if ((widget.offset.top > 0 || widget.offset.bottom > 0)) {
      final double translateY = MediaQuery.of(context).size.height *
          (widget.offset.top > 0 ? -widget.offset.top : widget.offset.bottom);
      container = Transform.translate(
        offset: Offset(0, translateY * (1 - _controller.value)),
        child: container,
      );
    }

    return container;
  }

  Widget? _invisibleCover() {
    final Container container = Container(
      color: _colorTransitionScaffold.evaluate(_controller),
    );
    if (_controller.value != 1.0 && !widget.tapScaffoldEnabled) {
      return BlockSemantics(
        child: GestureDetector(
          excludeFromSemantics: defaultTargetPlatform == TargetPlatform.android,
          onTap: widget.onTapClose || !_swipe ? close : null,
          child: Semantics(
            label: MaterialLocalizations.of(context).modalBarrierDismissLabel,
            child: container,
          ),
        ),
      );
    }
    return null;
  }

  Widget? get _leftChild {
    return widget.leftChild;
  }

  Widget? get _rightChild {
    return widget.rightChild;
  }

  Widget _animatedChild() {
    Widget? child =
        _position == InnerDrawerDirection.start ? _leftChild : _rightChild;
    if (_swipeChild) {
      child = GestureDetector(
        onHorizontalDragUpdate: _move,
        onHorizontalDragEnd: _settle,
        child: child,
      );
    }
    final Widget container = SizedBox(
      width: widget.proportionalChildArea ? _width - _widthWithOffset : _width,
      height: MediaQuery.of(context).size.height,
      child: child,
    );

    switch (_animationType) {
      case InnerDrawerAnimation.linear:
        return Align(
          alignment: _drawerOuterAlignment!,
          widthFactor: 1 - (_controller.value),
          child: container,
        );
      case InnerDrawerAnimation.quadratic:
        return Align(
          alignment: _drawerOuterAlignment!,
          widthFactor: 1 - (_controller.value / 2),
          child: container,
        );
      default:
        return container;
    }
  }

  Widget _trigger(AlignmentDirectional alignment, Widget? child) {
    final bool drawerIsStart = _position == InnerDrawerDirection.start;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    double dragAreaWidth = drawerIsStart ? padding.left : padding.right;

    if (Directionality.of(context) == TextDirection.rtl) {
      dragAreaWidth = drawerIsStart ? padding.right : padding.left;
    }
    dragAreaWidth = max(dragAreaWidth, _kEdgeDragWidth);

    if (_controller.status == AnimationStatus.completed &&
        _swipe &&
        child != null) {
      return Align(
        alignment: alignment,
        child: Container(color: Colors.transparent, width: dragAreaWidth),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initWidth == 400 ||
        MediaQuery.of(context).orientation != _orientation) {
      _updateWidth();
      _orientation = MediaQuery.of(context).orientation;
    }

    final double offset = 0.5 - _offset * 0.5;

    final double wFactor = (_controller.value * (1 - offset)) + offset;

    return Container(
      decoration: widget.backgroundDecoration ??
          BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
      child: Stack(
        alignment: _drawerInnerAlignment!,
        children: <Widget>[
          FocusScope(node: _focusScopeNode, child: _animatedChild()),
          GestureDetector(
            key: _gestureDetectorKey,
            onTap: () {},
            onHorizontalDragDown: _swipe ? _handleDragDown : null,
            onHorizontalDragUpdate: _swipe ? _move : null,
            onHorizontalDragEnd: _swipe ? _settle : null,
            excludeFromSemantics: true,
            child: RepaintBoundary(
              child: Stack(
                children: <Widget>[
                  if (_controller.value != 0 ||
                      _animationType == InnerDrawerAnimation.linear)
                    Container(
                      width: _controller.value == 0 ||
                              _animationType == InnerDrawerAnimation.linear
                          ? 0
                          : null,
                      color: _colorTransitionChild.evaluate(_controller),
                    ),
                  Align(
                    alignment: _drawerOuterAlignment!,
                    child: Align(
                      alignment: _drawerInnerAlignment!,
                      widthFactor: wFactor,
                      child: RepaintBoundary(child: _scaffold()),
                    ),
                  ),
                  _trigger(AlignmentDirectional.centerStart, _leftChild),
                  _trigger(AlignmentDirectional.centerEnd, _rightChild),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IDOffset {
  const IDOffset.horizontal(
    double horizontal,
  )   : left = horizontal,
        top = 0.0,
        right = horizontal,
        bottom = 0.0;

  const IDOffset.only({
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
  })  : assert(top >= 0.0 &&
            top <= 1.0 &&
            left >= 0.0 &&
            left <= 1.0 &&
            right >= 0.0 &&
            right <= 1.0 &&
            bottom >= 0.0 &&
            bottom <= 1.0),
        assert(top >= 0.0 && bottom == 0.0 || top == 0.0 && bottom >= 0.0);

  final double left;

  final double top;

  final double right;

  final double bottom;
}
