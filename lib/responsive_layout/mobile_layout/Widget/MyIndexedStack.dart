import 'package:flutter/material.dart';

class MyIndexedStack extends StatefulWidget {
  const MyIndexedStack({
    Key? key,
    required this.index,
    this.axis = Axis.horizontal,
    this.slideOffset = 0.03,
    required this.children,
    this.duration = const Duration(milliseconds: 100),
    required this.reload,
  }) : super(key: key);

  final int index;
  final List<Widget> children;
  final Duration duration;
  final double slideOffset;
  final Axis axis;
  final List<int> reload;

  @override
  State<MyIndexedStack> createState() => _MyIndexedStackState();
}

class _MyIndexedStackState extends State<MyIndexedStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late final Animation<Offset> _slideAnimation;
  late final Animation<Offset> _slideAnimation2;
  late final Animation<double> _opacityAnimation;

  bool _isForward = true;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: widget.duration);

    _slideAnimation = _getAnimationIn();

    _slideAnimation2 = _getAnimationOut();

    _opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant MyIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      bool flag = false;

      if (widget.index > oldWidget.index) {
        flag = true;
      }

      setState(() {
        _isForward = flag;
      });

      _animationController.forward(from: 0.0);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _opacityAnimation,
          child: SlideTransition(
            position: _isForward ? _slideAnimation : _slideAnimation2,
            child: child,
          ),
        );
      },
      child: IndexedStack(index: widget.index, children: widget.children,), 
    );
  }

  Animation<Offset> _getAnimationIn() {
    if (widget.axis == Axis.horizontal) {
      return Tween(begin: Offset(widget.slideOffset, 0), end: Offset.zero)
          .animate(_animationController);
    } else {
      return Tween(begin: Offset(0, widget.slideOffset), end: Offset.zero)
          .animate(_animationController);
    }
  }

  Animation<Offset> _getAnimationOut() {
    if (widget.axis == Axis.horizontal) {
      return Tween(begin: Offset(-widget.slideOffset, 0), end: Offset.zero)
          .animate(_animationController);
    } else {
      return Tween(begin: Offset(0, -widget.slideOffset), end: Offset.zero)
          .animate(_animationController);
    }
  }
}
