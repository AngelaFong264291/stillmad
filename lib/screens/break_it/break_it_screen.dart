import 'package:flutter/material.dart';
import 'package:stillmad/models/release_mode.dart';
import 'package:stillmad/screens/shared/release_mode_screen.dart';

class BreakItScreen extends StatelessWidget {
  const BreakItScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReleaseModeScreen(
      mode: ReleaseMode.breakIt,
      prompt: 'Tap until the surface gives way.',
      actionLabel: 'Break the charge',
    );
  }
}
