
import 'package:flutter/material.dart';

class ContextValues {
  var halfScreen;
  var topScreen;
  var hasAppBar;
  var appBarMaxHeight;

  ContextValues(BuildContext context) {
    halfScreen = (MediaQuery.of(context).size.height / 2);
    topScreen = MediaQuery.of(context).size.height;
    hasAppBar = Scaffold.of(context).hasAppBar;
    appBarMaxHeight = Scaffold.of(context).appBarMaxHeight;
  }
}