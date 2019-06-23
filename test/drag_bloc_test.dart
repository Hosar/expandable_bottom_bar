import 'package:expandable_app_bottom_bar/drag_bloc.dart';
import 'package:expandable_app_bottom_bar/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'given an autohide true, should return less than default height (50) for bottomBar',
      () async {
    DraggingBloc draggingBloc = DraggingBloc(autoHide: true);
    var defaultHeight = 50.0;
    draggingBloc.draggingDirection.add(DraggingDirection.up_manual);
    draggingBloc.verticalDragging.add(VerticalDrag(positionY: 10));

    draggingBloc.currentPosition.listen((Position position) {
      print(position);
      expect(position.bottomBarHeight, lessThan(defaultHeight));
    });
  });

  test('given an autohide false, should always return the default height',
      () async {
    DraggingBloc draggingBloc = DraggingBloc(autoHide: false);
    var defaultHeight = 50.0;
    draggingBloc.draggingDirection.add(DraggingDirection.none);
    draggingBloc.draggingDirection.add(DraggingDirection.up_manual);
    draggingBloc.verticalDragging.add(VerticalDrag(positionY: 10));

    var currentPosition = draggingBloc.currentPosition.skip(2);

    currentPosition.listen(expectAsync1((Position position) {
      expect(position.bottomBarHeight, equals(defaultHeight));
    }));
  });

  test('given a direction none, should reset the position', () async {
    DraggingBloc draggingBloc = DraggingBloc(autoHide: true);
    var defaultHeight = 50.0;
    draggingBloc.draggingDirection.add(DraggingDirection.up_manual);
    draggingBloc.verticalDragging.add(VerticalDrag(positionY: 10));
    draggingBloc.draggingDirection.add(DraggingDirection.none);

    var currentPosition = draggingBloc.currentPosition.skip(2);
    currentPosition.listen(expectAsync1((Position position) {
      expect(position.bottomBarHeight, equals(defaultHeight));
    }));
  });
  test(
      'when dragging down should increase the bottomBarHeight unless it has reached the maximum',
      () async {
    var defaultPosition = Position();
    defaultPosition.reset();
    DraggingBloc draggingBloc = DraggingBloc(autoHide: true);
    draggingBloc.draggingDirection.add(DraggingDirection.none);
    draggingBloc.draggingDirection.add(DraggingDirection.down_manual);
    draggingBloc.verticalDragging.add(VerticalDrag(positionY: 10));

    var currentPosition = draggingBloc.currentPosition.skip(2);
    currentPosition.listen(expectAsync1((Position position) {
      expect(position, defaultPosition);
    }));
  });

  test('when dragging up should decrease the bottomBarHeight', () async {
    var afterDraggingDown = 38.5;
    var bottomBarStart = 40.0;
    DraggingBloc draggingBloc = DraggingBloc(autoHide: true);
    draggingBloc.position =
        Position(bottomBarHeight: bottomBarStart, animationHeight: 300);

    draggingBloc.draggingDirection.add(DraggingDirection.up_manual);
    draggingBloc.verticalDragging.add(VerticalDrag(positionY: 10));
    draggingBloc.verticalDragging.add(VerticalDrag(positionY: 10));
    draggingBloc.verticalDragging.add(VerticalDrag(positionY: 10));

    var currentPosition = draggingBloc.currentPosition.skip(2);

    currentPosition.listen((Position position) {
      expect(position.bottomBarHeight, afterDraggingDown);
    });
  });

  test('when dragging up should increase the animationHeight', () async {
    var animationHeightStart = 300.0;
    var animationHeightEnd = 330.0;
    DraggingBloc draggingBloc = DraggingBloc(autoHide: true);
    draggingBloc.position =
        Position(bottomBarHeight: 50, animationHeight: animationHeightStart);

    draggingBloc.draggingDirection.add(DraggingDirection.up_manual);
    draggingBloc.verticalDragging.add(VerticalDrag(positionY: 10));
    draggingBloc.verticalDragging.add(VerticalDrag(positionY: 10));
    draggingBloc.verticalDragging.add(VerticalDrag(positionY: 10));

    var currentPosition = draggingBloc.currentPosition.skip(2);

    currentPosition.listen((Position position) {
      print(position);
      expect(position.animationHeight, animationHeightEnd);
    });
  });

  test('when dragging down should decrease the animationHeight', () async {
    var animationHeightStart = 300.0;
    var animationHeightEnd = 270.0;
    DraggingBloc draggingBloc = DraggingBloc(autoHide: true);
    draggingBloc.position =
        Position(bottomBarHeight: 50, animationHeight: animationHeightStart);

    draggingBloc.draggingDirection.add(DraggingDirection.down_manual);
    draggingBloc.verticalDragging.add(VerticalDrag(positionY: 10));
    draggingBloc.verticalDragging.add(VerticalDrag(positionY: 10));
    draggingBloc.verticalDragging.add(VerticalDrag(positionY: 10));

    var currentPosition = draggingBloc.currentPosition.skip(2);

    currentPosition.listen((Position position) {
      print(position);
      expect(position.animationHeight, animationHeightEnd);
    });
  });
}
