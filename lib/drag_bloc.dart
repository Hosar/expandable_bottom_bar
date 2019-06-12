import 'dart:async';

import 'package:expandable_bottom_bar/position_handlers.dart';

import 'model.dart';



class DraggingBloc {
  final bool autoHide;
  Position position;
  DraggingDirection _currentDirection = DraggingDirection.none;
  final _verticalDraggingController = StreamController<VerticalDragEvent>();
  final _draggingDirectionController = StreamController<DraggingDirection>();
  final _positionController = StreamController<Position>();

  Sink<VerticalDragEvent> get verticalDragging =>
      _verticalDraggingController.sink;
  Sink<DraggingDirection> get draggingDirection =>
      _draggingDirectionController.sink;
  Stream<VerticalDragEvent> get dragging => _verticalDraggingController.stream;
  Stream<Position> get currentPosition => _positionController.stream;

  DraggingBloc({this.autoHide}) {
    position = Position()..reset();
    _draggingDirectionController.stream.listen((direction) {
      if (direction == DraggingDirection.none) {
        position.reset();
      }
      _currentDirection = direction;
      _positionController.sink.add(position);
      return;
    });

    _verticalDraggingController.stream.listen((VerticalDragEvent dragEvent) {
      PositionActionsController controller = PositionActionsController(position,
          _positionController, _currentDirection, dragEvent, autoHide);
      controller.execute();
    });
  }

  dispose() {
    _positionController?.close();
    _verticalDraggingController?.close();
    _draggingDirectionController?.close();
  }
}

class PositionActionsController {
  List<PositionActionsHandler> handlers;

  PositionActionsController(
      Position position,
      StreamController<Position> positionController,
      DraggingDirection currentDirection,
      VerticalDragEvent dragEvent,
      bool autoHide) {
    handlers = List<PositionActionsHandler>();
    NoneHandler noneHandler = NoneHandler(
        position, positionController, currentDirection, dragEvent, autoHide);
    handlers.add(noneHandler);

    DownHandler downHandler = DownHandler(
        position, positionController, currentDirection, dragEvent, autoHide);
    handlers.add(downHandler);

    DownManualHandler downManualHandler = DownManualHandler(
        position, positionController, currentDirection, dragEvent, autoHide);
    handlers.add(downManualHandler);

    UpHandler upHandler = UpHandler(
        position, positionController, currentDirection, dragEvent, autoHide);
    handlers.add(upHandler);

    UpManualHandler upManualHandler = UpManualHandler(
        position, positionController, currentDirection, dragEvent, autoHide);
    handlers.add(upManualHandler);
  }

  execute() {
    handlers.forEach((action) {
      var res = action.handle();
      if (res) {
        return;
      }
    });
  }
}

