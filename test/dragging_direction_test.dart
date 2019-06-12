import 'package:expandable_bottom_bar/dragging_direction.dart';
import 'package:expandable_bottom_bar/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('given the start values, should return direction none', () async {
    var previousDy = 0.0;
    var dy = 0.0;
    var direction = getDraggingDirection(previousDy: previousDy, dy: dy);
    expect(direction, DraggingDirection.none);
  });

  test('given dy negative, should return direction down', () async {
    var previousDy = 0.0;
    var dy = -1.0;
    var direction = getDraggingDirection(previousDy: previousDy, dy: dy);
    expect(direction, DraggingDirection.down);
  });

  test('given dy positive, should return direction up', () async {
    var previousDy = 0.0;
    var dy = 1.0;
    var direction = getDraggingDirection(previousDy: previousDy, dy: dy);
    expect(direction, DraggingDirection.up);
  });

  test(
      'given a previous value positive and dy increasing should return direction up',
      () async {
    var previousDy = 1.0;
    var dy = 1.14;
    var direction = getDraggingDirection(previousDy: previousDy, dy: dy);
    expect(direction, DraggingDirection.up);
  });

  test(
      'given a previous value positive and dy decreasing should return direction down',
      () async {
    var previousDy = 1.24;
    var dy = 1.1;
    var direction = getDraggingDirection(previousDy: previousDy, dy: dy);
    expect(direction, DraggingDirection.down);
  });

  test(
      'given a previous value negative and dy decreasing should return direction down',
      () async {
    var previousDy = -1.42;
    var dy = -1.65;
    var direction = getDraggingDirection(previousDy: previousDy, dy: dy);
    expect(direction, DraggingDirection.down);
  });
  test(
      'given a previous value negative and dy increasing should return direction up',
      () async {
    var previousDy = -77.72;
    var dy = -76.14;
    var direction = getDraggingDirection(previousDy: previousDy, dy: dy);
    expect(direction, DraggingDirection.up);
  });
}
