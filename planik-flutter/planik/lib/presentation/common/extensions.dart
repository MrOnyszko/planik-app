import 'package:flutter/material.dart';
import 'package:planik/presentation/common/theme.dart';

extension AppThemes on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  Palette get palette => AppTheme.paletteOf(this);
}
