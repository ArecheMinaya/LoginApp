import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_app/src/features/auth/presentation/widgets/skills_card.dart';
import 'package:login_app/src/shared/widgets/theme_mode_button.dart';
import 'package:redux/redux.dart';

import 'package:login_app/src/app/redux/app_state.dart';
import 'package:login_app/src/features/auth/redux/auth_state.dart';
import 'package:login_app/src/features/auth/redux/auth_actions.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _Vm>(
      distinct: true,
      converter: (Store<AppState> store) => _Vm.fromStore(store),
      builder: (context, vm) {
        final t = Theme.of(context).textTheme;

        return Scaffold(
          appBar: AppBar(
            leading: SizedBox.fromSize(),
            actions: [ThemeModeButton()],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  Text("Te autenticaste con ${vm.email}", style: t.titleMedium),
                  const SizedBox(height: 22),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),

                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        radius: 30,
                        child: const Icon(Icons.person),
                      ),
                      title: Text('¡Bienvenido!', style: t.headlineSmall),
                      subtitle: Text(
                        "Soy Brian, Desarrollador mobile ",
                        style: t.bodyMedium,
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),
                  Text("Habilidades", style: t.titleMedium),
                  const SizedBox(height: 12),
                  Wrap(
                    children: [
                      SkillsCard(
                        skill: Skills(
                          name: 'Flutter',
                          icon: '0xe1b1',
                          color: Colors.blue,
                        ),
                      ),
                      SkillsCard(
                        skill: Skills(
                          name: 'React',
                          icon: '0xe1b2',
                          color: Colors.green,
                        ),
                      ),

                      SkillsCard(
                        skill: Skills(
                          name: 'Kotlin',
                          icon: '0xe1b3',
                          color: Colors.orange,
                        ),
                      ),
                      SkillsCard(
                        skill: Skills(
                          name: 'Swift',
                          icon: '0xe1b4',
                          color: Colors.red,
                        ),
                      ),
                      SkillsCard(
                        skill: Skills(
                          name: 'Kotlin',
                          icon: '0xe1b3',
                          color: Colors.orange,
                        ),
                      ),
                      SkillsCard(
                        skill: Skills(
                          name: 'Swift',
                          icon: '0xe1b4',
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),
                  Text("Widget de ejemplo", style: t.titleMedium),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 10,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      'Small Card',
                                      style: t.bodySmall?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Headline Small',
                                    style: t.headlineSmall,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.access_alarm, size: 20),
                                      SizedBox(width: 2),
                                      Text('text example', style: t.bodySmall),
                                      SizedBox(width: 8),
                                      Icon(Icons.star, size: 20),
                                      SizedBox(width: 2),
                                      Text('text example', style: t.bodySmall),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox.expand(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary
                                          .withValues(alpha: 0.2),
                                      strokeWidth: 4,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).colorScheme.onPrimary,
                                      ),
                                      value: 0.73,
                                    ),
                                  ),

                                  Text(
                                    '73%',
                                    style: t.bodyMedium?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Vm {
  final String? email;
  final bool isLoading;
  final VoidCallback onLogout;

  const _Vm({
    required this.email,
    required this.isLoading,
    required this.onLogout,
  });

  factory _Vm.fromStore(Store<AppState> store) {
    final auth = store.state.auth;
    return _Vm(
      email: auth.userInfo?.email, // ajusta si usas userInfo
      isLoading: auth.status == AuthStatus.loading,
      onLogout: () => store.dispatch(LogoutRequested()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Vm && email == other.email && isLoading == other.isLoading;

  @override
  int get hashCode => Object.hash(email, isLoading);
}
