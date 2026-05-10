import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stillmad/models/release_mode.dart';
import 'package:stillmad/services/haptic_service.dart';
import 'package:stillmad/services/sound_service.dart';
import 'package:stillmad/widgets/glass_panel.dart';
import 'package:stillmad/widgets/neon_button.dart';
import 'package:stillmad/widgets/particle_background.dart';

class ReleaseModeScreen extends StatefulWidget {
  const ReleaseModeScreen({
    required this.mode,
    required this.prompt,
    required this.actionLabel,
    super.key,
  });

  final ReleaseMode mode;
  final String prompt;
  final String actionLabel;

  @override
  State<ReleaseModeScreen> createState() => _ReleaseModeScreenState();
}

class _ReleaseModeScreenState extends State<ReleaseModeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
      lowerBound: 0.92,
      upperBound: 1,
      value: 1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _release() async {
    final haptics = context.read<HapticService>();
    final sounds = context.read<SoundService>();

    await haptics.heavy();
    await sounds.playReleaseCue();
    await _controller.reverse();
    await _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.mode.title)),
      body: ParticleBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: ScaleTransition(
                      scale: _controller,
                      child: GlassPanel(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              widget.mode.icon,
                              color: widget.mode.color,
                              size: 72,
                            ),
                            const SizedBox(height: 22),
                            Text(
                              widget.mode.verb,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.prompt,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                NeonButton(
                  label: widget.actionLabel,
                  color: widget.mode.color,
                  icon: widget.mode.icon,
                  onPressed: _release,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
