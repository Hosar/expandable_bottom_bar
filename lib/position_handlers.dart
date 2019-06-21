import 'dart:async';

import 'model.dart';

abstract class PositionActionsHandler {
  final Position position;
  final StreamController<Position> positionController;
  final DraggingDirection currentDirection;
  final VerticalDragEvent dragEvent;
  final bool autoHide;
  PositionActionsHandler(this.position, this.positionController,
      this.currentDirection, this.dragEvent, this.autoHide);
  bool handle();
}

class NoneHandler extends PositionActionsHandler {
  NoneHandler(
    Position position,
    StreamController<Position> positionController,
    DraggingDirection currentDirection,
    VerticalDragEvent dragEvent,
    bool autoHide,
  ) : super(position, positionController, currentDirection, dragEvent,
            autoHide);
  @override
  bool handle() {
    if (currentDirection == DraggingDirection.none) {
      positionController.sink.add(position);
      return true;
    }
    return false;
  }
}

class DownHandler extends PositionActionsHandler {
  DownHandler(
    Position position,
    StreamController<Position> positionController,
    DraggingDirection currentDirection,
    VerticalDragEvent dragEvent,
    bool autoHide,
  ) : super(position, positionController, currentDirection, dragEvent,
            autoHide);
  @override
  bool handle() {
    if (currentDirection == DraggingDirection.down) {
      position.decrement(dragEvent.positionY);
      position.incrementBottomBar(autoHide);
      positionController.sink.add(position);
      return true;
    }
    return false;
  }
}

class DownManualHandler extends PositionActionsHandler {
  DownManualHandler(
    Position position,
    StreamController<Position> positionController,
    DraggingDirection currentDirection,
    VerticalDragEvent dragEvent,
    bool autoHide,
  ) : super(position, positionController, currentDirection, dragEvent,
            autoHide);
  @override
  bool handle() {
    if (currentDirection == DraggingDirection.down_manual) {
      position.decrementManual(dragEvent.positionY);
      position.incrementBottomBar(autoHide);
      positionController.sink.add(position);
      return true;
    }
    return false;
  }
}

class UpHandler extends PositionActionsHandler {
  UpHandler(
    Position position,
    StreamController<Position> positionController,
    DraggingDirection currentDirection,
    VerticalDragEvent dragEvent,
    bool autoHide,
  ) : super(position, positionController, currentDirection, dragEvent,
            autoHide);
  @override
  bool handle() {
    if (currentDirection == DraggingDirection.up) {
      position.increment(dragEvent.positionY);
      position.decrementBottomBar(autoHide);
      positionController.sink.add(position);
      return true;
    }
    return false;
  }
}

class UpManualHandler extends PositionActionsHandler {
  UpManualHandler(
    Position position,
    StreamController<Position> positionController,
    DraggingDirection currentDirection,
    VerticalDragEvent dragEvent,
    bool autoHide,
  ) : super(position, positionController, currentDirection, dragEvent,
            autoHide);
  @override
  bool handle() {
    if (currentDirection == DraggingDirection.up_manual) {
      position.incrementManual(dragEvent.positionY);
      position.decrementBottomBar(autoHide);
      positionController.sink.add(position);
      return true;
    }
    return false;
  }
}
