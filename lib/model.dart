import 'package:quiver_hashcode/hashcode.dart';
enum DraggingDirection { up, up_manual, down, down_manual, none }

class Position {
  double bottomBarHeight;
  double animationHeight;

  Position({this.bottomBarHeight = 0.0, this.animationHeight = 0.0});

  @override
  String toString() {
    return 'bottomBarHeight: $bottomBarHeight - animationHeight: $animationHeight';
  }

  bool operator ==(o) =>
      o is Position &&
      bottomBarHeight == o.bottomBarHeight &&
      animationHeight == o.animationHeight;
  int get hashCode => hash2(bottomBarHeight.hashCode, animationHeight.hashCode);

  reset() {
    bottomBarHeight = 50;
    animationHeight = 0;
  }

  decrement(double dy) {
    var dyDecrease = dy.abs() * 4.0;

    if (animationHeight - dyDecrease < 0) {
      animationHeight = 0;
      return;
    }
    animationHeight = animationHeight - dyDecrease;
  }

  decrementManual(double dy) {
    var dyDecrease = dy.abs();

    if (animationHeight - dyDecrease < 0) {
      animationHeight = 0;
      return;
    }
    animationHeight = animationHeight - dyDecrease;
  }

  increment(double dy) {
    if (animationHeight == 0.0) {
      animationHeight += 45;
      return;
    }
    animationHeight = animationHeight + (dy.abs() * 4);
  }

  incrementManual(double dy) {
    if (animationHeight == 0.0) {
      animationHeight += 45;
      return;
    }
    animationHeight = animationHeight + dy.abs();
  }

  decrementBottomBar(bool autoHide) {
    if (!autoHide) {
      bottomBarHeight = 50;
      return;
    }
    if ((bottomBarHeight - 0.5) < 0) {
      bottomBarHeight = 0;
      return;
    }
    bottomBarHeight = bottomBarHeight - 0.5;
  }

  incrementBottomBar(bool autoHide) {
    if (!autoHide) {
      bottomBarHeight = 50;
      return;
    }
    if ((bottomBarHeight + 1.2) > 50) {
      bottomBarHeight = 50;
      return;
    }
    bottomBarHeight = bottomBarHeight + 1.2;
  }
}

abstract class VerticalDragEvent {
  double positionY;
  double updatePosition();
}

class VerticalDrag implements VerticalDragEvent {
  double positionY;
  VerticalDrag({this.positionY});
  updatePosition() {
    positionY += 15;
    return positionY;
  }
}

class VerticalDragDownToEnd implements VerticalDragEvent {
  double positionY;
  VerticalDragDownToEnd({this.positionY});
  updatePosition() {
    positionY -= 15;
    return positionY;
  }
}