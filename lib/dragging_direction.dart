import 'model.dart';

DraggingDirection getDraggingDirection({double previousDy, double dy}) {
  var direction = DraggingDirection.none;
  if (previousDy == 0) {
    previousDy = dy;
    if (dy > 0) {
      direction = DraggingDirection.up;
      return direction;
    }
    if (dy < 0) {
      direction = DraggingDirection.down;
      return direction;
    }
    return direction;
  }

  if (previousDy > 0) {
    if (dy > previousDy) {
      direction = DraggingDirection.up;
      return direction;
    }
    if (dy < previousDy) {
      direction = DraggingDirection.down;
      return direction;
    }
  }

  if (previousDy < 0) {
    if (dy < previousDy) {
      direction = DraggingDirection.down;
      return direction;
    }
    if (dy > previousDy) {
      direction = DraggingDirection.up;
      return direction;
    }
  }

  return direction;
}
