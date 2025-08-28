import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_app/src/app/presentation/routes.dart';
import 'package:login_app/src/core/utils/error_dialog.dart';
import 'package:login_app/src/core/utils/validators.dart';
import 'package:login_app/src/features/auth/redux/auth_actions.dart';
import 'package:login_app/src/features/auth/redux/auth_state.dart';
import 'package:login_app/src/shared/widgets/primary_button.dart';
import 'package:login_app/src/shared/widgets/theme_mode_button.dart';
import 'package:redux/redux.dart';

import '../../../../shared/widgets/app_text_field.dart';
import '../../../../app/redux/app_state.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _showPass = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return StoreConnector<AppState, _Vm>(
      distinct: true,
      converter: (Store<AppState> store) => _Vm.fromStore(store),
      onDidChange: (prev, next) async {
        final justBecameError =
            prev?.status != AuthStatus.error && next.status == AuthStatus.error;
        if (justBecameError && (next.errorMessage?.isNotEmpty ?? false)) {
          await ErrorDialog.show(context, next.errorMessage);
          if (!context.mounted) return;
          StoreProvider.of<AppState>(context).dispatch(ClearAuthError());
        }
      },
      builder: (context, vm) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [ThemeModeButton()],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Iniciar Sesión', style: t.headlineLarge),
                      const SizedBox(height: 8),
                      Text(
                        'Por favor ingresa tus credenciales',
                        style: t.bodyMedium,
                      ),

                      const SizedBox(height: 36),
                      // Email
                      AppTextField(
                        controller: _emailCtrl,
                        label: 'Correo',
                        hint: 'test@redux.com',
                        keyboardType: TextInputType.emailAddress,
                        validator: AppValidators.email,
                        suffixIcon: const Icon(Icons.email_outlined),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),

                      AppTextField(
                        controller: _passCtrl,
                        label: 'Contraseña',
                        obscureText: !_showPass,
                        validator: AppValidators.required("La contraseña"),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showPass ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () =>
                              setState(() => _showPass = !_showPass),
                        ),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submit(vm),
                      ),
                      const SizedBox(height: 16),

                      PrimaryButton(
                        text: 'Iniciar Sesión',
                        isLoading: vm.isLoading,
                        onPressed: () => _submit(vm),
                      ),

                      const SizedBox(height: 26),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.register);
                        },
                        child: Text.rich(
                          TextSpan(
                            style: t.bodyMedium,
                            children: [
                              TextSpan(text: "No tienes una cuenta? "),
                              TextSpan(
                                text: "Registrate",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _submit(_Vm vm) {
    if (_formKey.currentState?.validate() != true) return;
    vm.onLogin(_emailCtrl.text.trim(), _passCtrl.text);
  }
}

class _Vm {
  final AuthStatus status;
  final bool isLoading;
  final String? errorMessage;
  final void Function(String email, String pass) onLogin;

  _Vm({
    required this.isLoading,
    required this.errorMessage,
    required this.onLogin,
    required this.status,
  });

  factory _Vm.fromStore(Store<AppState> store) {
    final auth = store.state.auth;
    return _Vm(
      status: auth.status,
      isLoading: auth.status == AuthStatus.loading,
      errorMessage: auth.errorMessage,
      onLogin: (email, pass) =>
          store.dispatch(LoginRequested(email: email, password: pass)),
    );
  }
}
