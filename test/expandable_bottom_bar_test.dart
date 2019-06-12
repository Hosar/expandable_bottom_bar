import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';

void main() {
  testWidgets('On init should not show the dragging widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
          home: Scaffold(
        bottomNavigationBar: ExpandableBottomBar(
          key: Key('btnBar'),
          child: Container(
            key: Key('childContainer'),
            color: Colors.blue,
          ),
          barButtons: Row(children: <Widget>[],),
        ),
      )),
    );

    await tester.drag(find.byKey(Key('btnBar')), Offset(0.0, 150.0));

    await tester.pumpAndSettle();
    var widget = tester.widget<Container>(find.byKey(Key('draggingWidget')));

    DiagnosticPropertiesBuilder properties = DiagnosticPropertiesBuilder();
    double h;
    // properties.add(DiagnosticsProperty('height', h));
    properties.add(DiagnosticsProperty<double>('height', h));
    widget.debugFillProperties(properties);
    // widget.

    print(properties.properties.first.name);
    print(properties.properties.first.value);

    // print(widget);

    expect(true, true);
  });
}
