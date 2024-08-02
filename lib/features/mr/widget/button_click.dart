import 'dart:math';

import 'package:flutter/material.dart';

class ButtonClick extends StatefulWidget {
  const ButtonClick(
      {super.key,
      required Offset position,
      required Size size,
      required OverlayEntry overlayEntry})
      : _position = position,
        _size = size,
        _overlayEntry = overlayEntry;

  final Offset _position;
  final Size _size;
  final OverlayEntry _overlayEntry;

  @override
  State<ButtonClick> createState() => _ButtonClickState();
}

class _ButtonClickState extends State<ButtonClick>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  late final Animation<double> _rotation;

  late final Tween<Offset> _positionTween;
  late final Animation<Offset> _position;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _controller.addListener(() {
      if (_controller.isCompleted) {
        widget._overlayEntry.remove();
      } else {
        setState(() {});
      }
    });

    _opacity = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0),
        weight: 50,
      ),
    ]).animate(_controller);

    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.5, end: 1.0),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.5),
        weight: 50,
      ),
    ]).animate(_controller);

    final beginAngle = Random.secure().nextDouble() - 0.5;
    const endAngle = 0.0;

    _rotation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: beginAngle, end: endAngle),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: ConstantTween(endAngle),
        weight: 50,
      ),
    ]).animate(_controller);

    _positionTween = Tween<Offset>(begin: Offset.zero);

    _position = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: ConstantTween(Offset.zero),
        weight: 50,
      ),
      TweenSequenceItem(tween: _positionTween, weight: 50),
    ]).animate(_controller);

    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenCenter = screenWidth / 2.0;

    final distance = screenCenter - widget._position.dx;
    final leftOffset = distance * Random.secure().nextDouble();

    final topOffset = -widget._position.dy;

    _positionTween.end = Offset(leftOffset, topOffset);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Transform.translate(
        offset: _position.value,
        child: Transform.scale(
          scale: _scale.value,
          child: Transform.rotate(
            angle: _rotation.value,
            child: Opacity(
              opacity: _opacity.value,
              child: Icon(
                size: widget._size.height,
                Icons.thumb_up_alt,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      );
}