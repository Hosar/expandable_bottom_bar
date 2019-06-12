import 'package:flutter/animation.dart';

import 'drag_bloc.dart';
import 'model.dart';

enum Direction { Upwards, Downwards, None }

class HandlerHelper {
  Map<String, Function> operations;

  HandlerHelper(
      {DraggingBloc draggingBloc,
      AnimationController controller,
      Animation<double> animation,
      double topScreen}) {
    operations = Map();
    operations.putIfAbsent('stopOnDrag', () {
      var fn = () {
        return;
      };
      return fn;
    });
    operations.putIfAbsent('animateToTheTop', () {
      var fn = () {
        Animation<double> _animation;
        double begin = draggingBloc.position.animationHeight;
        controller.duration = Duration(seconds: 2);
        _animation = Tween(begin: begin, end: topScreen).animate(controller);
        draggingBloc.draggingDirection.add(DraggingDirection.up);
        return _animation;
      };
      return fn;
    });
    operations.putIfAbsent('animateToBegin', () {
      var fn = () {
        Animation<double> _animation;
        double begin = draggingBloc.position.animationHeight;
        controller.duration = Duration(milliseconds: 30);
        _animation = Tween(begin: begin, end: 50.0).animate(controller);
        draggingBloc.draggingDirection.add(DraggingDirection.down);
        return _animation;
      };
      return fn;
    });
  }

  execute(String _action) {
    var action = operations.entries.firstWhere((data) => data.key == _action);
    return action.value();
  }
}
