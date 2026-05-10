import 'package:flutter/material.dart';
import 'package:stillmad/models/release_mode.dart';
import 'package:stillmad/screens/shared/release_mode_screen.dart';

class BurnItScreen extends StatelessWidget {
  const BurnItScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReleaseModeScreen(
      mode: ReleaseMode.burnIt,
      prompt: 'Watch it become light, heat, and nothing useful to carry.',
      actionLabel: 'Burn it down',
    );
  }
}
