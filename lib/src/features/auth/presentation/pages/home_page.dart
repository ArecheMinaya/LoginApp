import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_app/src/features/auth/presentation/widgets/icon_text.dart';
import 'package:login_app/src/features/auth/presentation/widgets/skills_card.dart';
import 'package:login_app/src/shared/widgets/primary_button.dart';
import 'package:login_app/src/shared/widgets/theme_mode_button.dart';
import 'package:redux/redux.dart';

import 'package:login_app/src/app/redux/app_state.dart';
import 'package:login_app/src/features/auth/redux/auth_state.dart';
import 'package:login_app/src/features/auth/redux/auth_actions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _Vm>(
      distinct: true,
      converter: (Store<AppState> store) => _Vm.fromStore(store),
      builder: (context, vm) {
        final t = Theme.of(context).textTheme;
        return PopScope(
          canPop: false,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [ThemeModeButton()],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Text(
                            "Te autenticaste con ${vm.email}",
                            style: t.titleMedium,
                          ),
                          const SizedBox(height: 22),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                            ),

                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                radius: 30,
                                child: const Icon(Icons.person),
                              ),
                              title: Text(
                                '¡Bienvenido!',
                                style: t.headlineSmall,
                              ),
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
                                  icon: 'lib/assets/images/flutter.png',
                                  color: Colors.blueAccent,
                                ),
                              ),
                              SkillsCard(
                                skill: Skills(
                                  name: 'React',
                                  icon: 'lib/assets/images/React_icon.png',
                                  color: Colors.blue,
                                ),
                              ),
                              SkillsCard(
                                skill: Skills(
                                  name: 'Kotlin',
                                  icon: 'lib/assets/images/kt_icon.png',
                                  color: Colors.orange,
                                ),
                              ),
                              SkillsCard(
                                skill: Skills(
                                  name: 'Swift',
                                  icon: 'lib/assets/images/swift.png',
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
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Columna flexible
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Pill/etiqueta
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 6,
                                            ),
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
                                          const SizedBox(height: 10),

                                          // Título
                                          Text(
                                            'Headline Small',
                                            style: t.headlineSmall,
                                          ),
                                          const SizedBox(height: 8),

                                          // En lugar de Row rígida, usamos Wrap que parte en varias líneas
                                          Wrap(
                                            spacing: 12,
                                            runSpacing: 6,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              IconText(
                                                icon: Icons.access_alarm,
                                                label: 'text example',
                                                textStyle: t.bodySmall,
                                              ),
                                              IconText(
                                                icon: Icons.star,
                                                label: 'text example',
                                                textStyle: t.bodySmall,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    // Tarjeta de progreso con ancho/alto fijos
                                    SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Positioned.fill(
                                                child: CircularProgressIndicator(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary
                                                          .withOpacity(0.2),
                                                  strokeWidth: 4,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(
                                                        Theme.of(
                                                          context,
                                                        ).colorScheme.onPrimary,
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
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 36),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: PrimaryButton(
                        text: "Cerrar Sesion",
                        onPressed: () => vm.onLogout(),
                      ),
                    ),
                  ],
                ),
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
}
