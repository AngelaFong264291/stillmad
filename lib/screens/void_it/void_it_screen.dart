import 'package:flutter/material.dart';
import 'package:stillmad/models/release_mode.dart';
import 'package:stillmad/screens/shared/release_mode_screen.dart';

class VoidItScreen extends StatelessWidget {
  const VoidItScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReleaseModeScreen(
      mode: ReleaseMode.voidIt,
      prompt: 'Drop the thought into the quiet.',
      actionLabel: 'Void the thought',
    );
  }
}
