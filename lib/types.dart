import 'package:flutter/material.dart';

typedef OnPanUpdateCallback = void Function(Offset offset);
typedef OnPanEndCallback = void Function(Offset offset);
typedef CloseButtonCallback = void Function();
typedef FloatingActionButtonCallback = Future Function();
typedef OnPanDownCallback = void Function(DragDownDetails details);