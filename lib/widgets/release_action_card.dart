import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stillmad/models/release_mode.dart';
import 'package:stillmad/services/haptic_service.dart';
import 'package:stillmad/widgets/neon_card.dart';

class ReleaseActionCard extends StatelessWidget {
  const ReleaseActionCard({required this.mode, super.key});

  final ReleaseMode mode;

  @override
  Widget build(BuildContext context) {
    return NeonCard(
      color: mode.color,
      onTap: () {
        context.read<HapticService>().light();
        Navigator.of(context).pushNamed(mode.route);
      },
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(mode.icon, color: mode.color, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mode.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mode.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Icon(Icons.chevron_right, color: mode.color),
          ],
        ),
      ),
    );
  }
}
