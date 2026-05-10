import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stillmad/core/routes/app_routes.dart';
import 'package:stillmad/core/theme/app_theme.dart';
import 'package:stillmad/models/release_mode.dart';
import 'package:stillmad/services/privacy_service.dart';
import 'package:stillmad/widgets/glass_panel.dart';
import 'package:stillmad/widgets/particle_background.dart';
import 'package:stillmad/widgets/release_action_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final privacy = context.watch<PrivacyService>();

    return Scaffold(
      body: ParticleBackground(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Stillmad',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Safety',
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.safety);
                        },
                        icon: const Icon(Icons.health_and_safety_outlined),
                      ),
                      IconButton(
                        tooltip: 'Rituals',
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.rituals);
                        },
                        icon: const Icon(Icons.history),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: GlassPanel(
                    child: Row(
                      children: [
                        const Icon(Icons.lock_outline, color: AppTheme.paper),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            'Private mode',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Switch(
                          value: privacy.privacyModeEnabled,
                          onChanged: privacy.setPrivacyMode,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) {
                    return ReleaseActionCard(mode: ReleaseMode.values[index]);
                  },
                  separatorBuilder: (_, _) => const SizedBox(height: 14),
                  itemCount: ReleaseMode.values.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
