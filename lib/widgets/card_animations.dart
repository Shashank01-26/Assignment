import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension WidgetExt on Widget {
  Widget myanimate({delay}) {
    return animate(
      effects: [
        FadeEffect(duration: NumDurationExtensions(600).milliseconds),
        SlideEffect(
            begin: const Offset(0, .1),
            duration: NumDurationExtensions(300).milliseconds),
      ],
      delay: NumDurationExtensions(delay).milliseconds,
    );
  }
}
