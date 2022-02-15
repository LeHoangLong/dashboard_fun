import 'package:dashboard_fun/screen_model.dart';
import 'package:flutter/rendering.dart';

ScreenModel checkScreenModel(BoxConstraints constraints) {
  if (constraints.maxWidth > 900) {
    return ScreenModel.large;
  } else {
    return ScreenModel.small;
  }
}
