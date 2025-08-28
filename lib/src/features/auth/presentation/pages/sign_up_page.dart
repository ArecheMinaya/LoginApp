import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_app/src/app/redux/app_state.dart';
import 'package:login_app/src/core/utils/validators.dart';
import 'package:login_app/src/features/auth/redux/auth_actions.dart';
import 'package:login_app/src/shared/widgets/app_text_field.dart';
import 'package:login_app/src/shared/widgets/primary_button.dart';
import 'package:login_app/src/shared/widgets/theme_mode_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _showPass = false;
  bool _showConfirm = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  String? _confirmValidator(String? v) {
    final value = (v ?? '');
    if (value.isEmpty) return 'Confirma tu contraseña';
    if (value != _passCtrl.text) return 'Las contraseñas no coinciden';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(actions: const [ThemeModeButton()]),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Regístrate',
                      style: t.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Crea tu cuenta para continuar',
                      style: t.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.75),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Email
                    AppTextField(
                      label: 'Correo',
                      hint: 'tucorreo@dominio.com',
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: AppValidators.email,
                      suffixIcon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 16),

                    // Password
                    AppTextField(
                      label: 'Contraseña',
                      controller: _passCtrl,
                      obscureText: !_showPass,
                      validator: AppValidators.password(),
                      textInputAction: TextInputAction.next,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showPass ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () => setState(() => _showPass = !_showPass),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Confirm password
                    AppTextField(
                      label: 'Confirmar contraseña',
                      controller: _confirmCtrl,
                      obscureText: !_showConfirm,
                      validator: _confirmValidator,
                      textInputAction: TextInputAction.done,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () =>
                            setState(() => _showConfirm = !_showConfirm),
                      ),
                    ),

                    const SizedBox(height: 26),

                    PrimaryButton(
                      text: 'Crear cuenta',
                      isLoading: _isSubmitting,
                      onPressed: () async {
                        if (_formKey.currentState?.validate() != true) return;

                        setState(() => _isSubmitting = true);

                        StoreProvider.of<AppState>(context).dispatch(
                          SignUpRequested(
                            email: _emailCtrl.text.trim(),
                            password: _passCtrl.text,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 26),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
