library expandable_bottom_bar;

import 'package:expandable_bottom_bar/app_context_values.dart';
import 'package:expandable_bottom_bar/handler_helper.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/drag_bloc.dart';

import 'hidden_content.dart';
import 'model.dart';

const Duration expandDuration = const Duration(seconds: 1);

/// An expandable app bar.
/// The expandable app bar allow you to have a hidden content which can be shown
/// if the user drags the bar up.
/// [barButtons] allows to pass a widget (typically a row) that contains the buttons
/// which will handle the app bar functionality.
/// [child] widget that contains the hidden content.
/// [scaffoldChild] widget that contains the hidden content, but this hidden content
/// is wrapped inside a Scaffold widget. Only child or scaffoldChild is allow no
/// both at same time.
/// [opacity] the oppacity of hidden content.
/// [stopOnDrag] if true when the user stops dragging the hidden content will stay visible
/// if false the hidden content will be expanded/narrowed to the top or the end of the screen and then disappear.
/// [autoHide] hides the app bottom bar while the user is dragging the hidden content.
///
/// ## Sample code
///
/// ```dart
/// bottomNavigationBar: ExpandableBottomBar(
///        autoHide: false,
///        stopOnDrag: true,
///        child: SomeImage(),
///        barButtons: Container(
///          color: Colors.pink,
///          child: Row(
///            mainAxisAlignment: MainAxisAlignment.center,
///            children: <Widget>[
///              FlatButton(
///                onPressed: () {},
///                child: Icon(Icons.arrow_back),
///              ),
///              FlatButton(
///                child: Icon(Icons.arrow_forward),
///                onPressed: () {);
///                },
///              )
///            ],
///         ),
///       ),
///     )
/// ```
class ExpandableBottomBar extends StatefulWidget
    implements PreferredSizeWidget {
  final Widget barButtons;
  final Widget child;
  final Widget scaffoldChild;
  final double opacity;
  final bool stopOnDrag;
  final bool autoHide;
  final Color color;

  ExpandableBottomBar(
      {Key key,
      @required this.barButtons,
      this.child,
      this.scaffoldChild,
      this.opacity = 1.0,
      this.stopOnDrag = false,
      this.autoHide = false,
      this.color,})
      : super(key: key) {
    assert(child != null);
    if (child != null && scaffoldChild != null) {
      throw 'Only child or scaffoldChild no both at same time';
    }
  }

  @override
  _ExpandableBottomBar createState() => _ExpandableBottomBar();

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}

class _ExpandableBottomBar extends State<ExpandableBottomBar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  DraggingBloc _draggingBloc;
  HandlerHelper _handler;
  ContextValues _contextValues;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: expandDuration, vsync: this);
    _draggingBloc = DraggingBloc(autoHide: widget.autoHide);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _contextValues = ContextValues(context);

    _handler = HandlerHelper(
        animation: _animation,
        controller: _controller,
        draggingBloc: _draggingBloc,
        topScreen: _contextValues.topScreen);
    return SingleChildScrollView(
      child: GestureDetector(
          onVerticalDragUpdate: (DragUpdateDetails details) {
            var dy = details.delta.dy;
            if (dy < 0) {
              _draggingBloc.draggingDirection.add(DraggingDirection.up_manual);
            } else {
              _draggingBloc.draggingDirection.add(
                DraggingDirection.down_manual,
              );
            }
            _draggingBloc.verticalDragging.add(VerticalDrag(positionY: dy));
          },
          onVerticalDragEnd: (DragEndDetails details) {
            this.onVerticalDragEnd();
          },
          child: StreamBuilder<Position>(
              stream: _draggingBloc.currentPosition,
              builder: (context, snapshot) {
                var _animationHeight = snapshot.data?.animationHeight;
                var _bottomBarHeight = snapshot.data?.bottomBarHeight;
                _animationHeight =
                    _animationHeight == null ? 0.0 : _animationHeight;
                _bottomBarHeight =
                    _bottomBarHeight == null ? 50.0 : _bottomBarHeight;
                return HiddenContent(
                  opacity: widget.opacity,
                  animationHeight: _animationHeight,
                  bottomBarHeight: _bottomBarHeight,
                  child: widget.child,
                  barButtons: widget.barButtons,
                  onVerticalDragUpdate: this.onVerticalDragUpdate,
                  animateToTop: this.animateToTop,
                  onDoubleTap: this.onDoubleTap,
                  color: widget.color,
                  showBar: this.shouldShowDraggingBar(widget.stopOnDrag, _animationHeight),
                );
              })),
    );
  }

  bool shouldShowDraggingBar(bool stopOnDrag, double animationHeight) {
    if (!stopOnDrag) {
      return false;
    }
    if (animationHeight >= 10) {
      return true;
    }

    return false;
  }

  void onVerticalDragEnd() {
    if (widget.stopOnDrag) {
      return;
    }

    double begin = _draggingBloc.position.animationHeight;

    if (begin >= _contextValues.halfScreen) {
      _animation = _handler.execute('animateToTheTop');
    } else {
      _animation = _handler.execute('animateToBegin');
    }

    _controller.forward();
    void handler() {
      {
        onDragEnd(_animation, _draggingBloc, _controller, _contextValues.topScreen, handler);
      }
    }

    _animation.addListener(handler);
  }

  void animateToTop() {
    _animation = _handler.execute('animateToTheTop');
    _controller.forward();
    var topScreen = _contextValues.topScreen;
    if(_contextValues.hasAppBar) {
      topScreen = _contextValues.topScreen - 160;
    }
    void handler() {
      {
        onDragEnd(_animation, _draggingBloc, _controller, topScreen, handler);
      }
    }

    _animation.addListener(handler);
  }

  void onVerticalDragUpdate(double dy) {
    if (dy < 0) {
      _draggingBloc.draggingDirection.add(DraggingDirection.up_manual);
    } else {
      _draggingBloc.draggingDirection.add(
        DraggingDirection.down_manual,
      );
    }
    _draggingBloc.verticalDragging.add(VerticalDrag(positionY: dy));
  }

  onDragEnd(Animation<double> animation, DraggingBloc draggingBloc,
      AnimationController controller, double topScreen, Function handler) {
    if (draggingBloc.position.animationHeight >= topScreen) {
      controller.stop();
      animation.removeListener(handler);
      return;
    }

    if (animation.isCompleted) {
      resetBehavior();
      animation.removeListener(handler);
      return;
    }
    draggingBloc.verticalDragging.add(VerticalDrag(positionY: 5.0));
  }

  onDoubleTap() {
    _animation = _handler.execute('animateToBegin');
    _controller.forward();
    void handler() {
      {
        onDragEnd(_animation, _draggingBloc, _controller, _contextValues.topScreen, handler);
      }
    }

    _animation.addListener(handler);
  }

  resetBehavior() {
    _draggingBloc.draggingDirection.add(DraggingDirection.none); // reset
    _controller.reset();
  }
}
