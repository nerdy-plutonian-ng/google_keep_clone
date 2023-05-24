import 'package:flutter/cupertino.dart';

extension SpacerExtensions on int {
  SizedBox get vSpacer => SizedBox(height: toDouble());
  SizedBox get hSpacer => SizedBox(width: toDouble());
}
