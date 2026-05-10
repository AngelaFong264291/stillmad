import 'package:flutter/material.dart';
import 'package:stillmad/models/release_mode.dart';
import 'package:stillmad/screens/shared/release_mode_screen.dart';

class MoveItScreen extends StatelessWidget {
  const MoveItScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReleaseModeScreen(
      mode: ReleaseMode.moveIt,
      prompt: 'Breathe, shake, and let your body finish the sentence.',
      actionLabel: 'Start movement',
    );
  }
}
