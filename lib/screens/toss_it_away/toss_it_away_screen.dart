import 'package:flutter/material.dart';
import 'package:stillmad/models/release_mode.dart';
import 'package:stillmad/screens/shared/release_mode_screen.dart';

class TossItAwayScreen extends StatelessWidget {
  const TossItAwayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReleaseModeScreen(
      mode: ReleaseMode.tossItAway,
      prompt: 'Name it, crumple it, and throw it out of frame.',
      actionLabel: 'Toss it away',
    );
  }
}
