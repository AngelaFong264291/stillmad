import 'package:flutter/material.dart';
import 'package:stillmad/widgets/glass_panel.dart';
import 'package:stillmad/widgets/particle_background.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safety')),
      body: ParticleBackground(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            GlassPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pause before impact',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'VENT 躁 is for emotional release, not self-harm, intimidation, or breaking real things. If the feeling is unsafe, step away from the phone and contact someone you trust or local emergency support.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
