import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
  final VoidCallback animateToTop;
  final Color color;
  const HiddenContent(
      {Key key,
      this.opacity,
      this.animationHeight,
      this.scaffoldChild,
      this.child,
      this.barButtons,
      this.bottomBarHeight,
      this.onVerticalDragUpdate,
      this.animateToTop,
      this.onDoubleTap,
      this.color})
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
      color: widget.color,
      key: Key('draggingWidget'),
      child: Column(children: <Widget>[

        Container(
          color: widget.color,
          height: 25.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            FloatingActionButton(
              backgroundColor: widget.color,
              onPressed: () {
                print('----');
                widget.onDoubleTap();
              },
              child: Icon(Icons.close),
            ),
            FloatingActionButton(
                backgroundColor: widget.color,
                onPressed: () {
                  widget.animateToTop();
                },
                child: Icon(Icons.open_in_browser))
          ]),
        ),
        Opacity(
            opacity: this.widget.opacity == null ? 1.0 : this.widget.opacity,
            child: Container(
              constraints: BoxConstraints(minWidth: width),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              height: widget.animationHeight,
              child: widgetToShow,
            )),
        Container(
          height: widget.bottomBarHeight,
          child: this.widget.barButtons,
        )
      ]),
    );
  }
}
