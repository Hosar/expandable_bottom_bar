import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'dragging_direction.dart';
import 'model.dart';

class HiddenContent extends StatefulWidget {
  final double opacity;
  final double animationHeight;
  final Widget scaffoldChild;
  final Widget child;
  final Widget barButtons;
  final double bottomBarHeight;
  final ValueSetter<double> onVerticalDragUpdate;
  final VoidCallback onDoubleTap;
  const HiddenContent(
      {Key key,
      this.opacity,
      this.animationHeight,
      this.scaffoldChild,
      this.child,
      this.barButtons,
      this.bottomBarHeight,
      this.onVerticalDragUpdate,
      this.onDoubleTap})
      : super(key: key);

  @override
  _HiddenContentState createState() => _HiddenContentState();
}

class _HiddenContentState extends State<HiddenContent> {
  DraggingDirection direction = DraggingDirection.none;
  double previousDy = 0.0;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var widgetToShow = this.widget.scaffoldChild != null
        ? this.widget.scaffoldChild
        : SingleChildScrollView(child: this.widget.child);
    return Container(
      color: Colors.transparent,
      key: Key('draggingWidget'),
      child: Column(children: <Widget>[
        Opacity(
            opacity: this.widget.opacity == null ? 1.0 : this.widget.opacity,
            child: GestureDetector(
              child: Container(
                constraints: BoxConstraints(minWidth: width),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                height: widget.animationHeight,
                child: widgetToShow,
              ),
              onDoubleTap: () {
                widget.onDoubleTap();
              },
              onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
                var direction = getDraggingDirection(
                    previousDy: previousDy, dy: details.offsetFromOrigin.dy);

                if (direction == DraggingDirection.down) {
                  var growFactor = -4 + (details.offsetFromOrigin.dy / 100);
                  this.widget.onVerticalDragUpdate(growFactor);
                } else {
                  var growFactor = 4 + (details.offsetFromOrigin.dy / 100);
                  this.widget.onVerticalDragUpdate(growFactor);
                }
                previousDy = details.offsetFromOrigin.dy;
              },
            )),
        Container(
          height: widget.bottomBarHeight,
          child: this.widget.barButtons,
        )
      ]),
    );
  }
}
