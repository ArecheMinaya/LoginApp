// import 'package:flutter/material.dart';
// import 'package:login_app/src/app/presentation/routes.dart';
// import 'package:login_app/src/shared/widgets/app_text_field.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Login', style: theme.textTheme.headlineLarge),
//               Text(
//                 'Please login to your account',
//                 style: theme.textTheme.bodyMedium,
//               ),
//               const SizedBox(height: 16),
//               AppTextField(label: "Email", controller: TextEditingController()),
//               const SizedBox(height: 26),
//               AppTextField(
//                 label: "Password",
//                 controller: TextEditingController(),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 26),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pushNamed(AppRoutes.home);
//                 },
//                 child: Text('Login'),
//               ),
//               const SizedBox(height: 26),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context).pushNamed(AppRoutes.register);
//                 },
//                 child: Text.rich(
//                   TextSpan(
//                     style: theme.textTheme.bodyMedium,
//                     children: [
//                       TextSpan(text: "Don't have an account? "),
//                       TextSpan(
//                         text: "Sign up",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_app/src/features/auth/redux/auth_actions.dart';
import 'package:login_app/src/features/auth/redux/auth_state.dart';
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
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [ThemeModeButton()],
          ),
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Bienvenido', style: t.headlineSmall),
                        const SizedBox(height: 16),

                        // Email
                        AppTextField(
                          controller: _emailCtrl,
                          label: 'Correo',
                          hint: 'test@redux.com',
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            final value = (v ?? '').trim();
                            if (value.isEmpty) return 'Ingresa tu correo';
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                            if (!emailRegex.hasMatch(value))
                              return 'Correo no válido';
                            return null;
                          },
                          prefixIcon: const Icon(Icons.email),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 12),

                        // Password
                        AppTextField(
                          controller: _passCtrl,
                          label: 'Contraseña',
                          obscureText: true,
                          validator: (v) {
                            final value = v ?? '';
                            if (value.isEmpty) return 'Ingresa tu contraseña';
                            if (value.length < 6) return 'Mínimo 6 caracteres';
                            return null;
                          },
                          prefixIcon: const Icon(Icons.lock),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submit(vm),
                        ),
                        const SizedBox(height: 16),

                        // Error
                        if (vm.errorMessage != null) ...[
                          Text(
                            vm.errorMessage!,
                            style: t.bodyMedium?.copyWith(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                        ],

                        // Botón login
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: vm.isLoading ? null : () => _submit(vm),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: vm.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text('Entrar'),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Demo credentials
                        TextButton(
                          onPressed: vm.isLoading
                              ? null
                              : () {
                                  _emailCtrl.text = 'test@redux.com';
                                  _passCtrl.text = '123456';
                                },
                          child: const Text('Usar credenciales demo'),
                        ),
                      ],
                    ),
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
  final bool isLoading;
  final String? errorMessage;
  final void Function(String email, String pass) onLogin;

  _Vm({
    required this.isLoading,
    required this.errorMessage,
    required this.onLogin,
  });

  factory _Vm.fromStore(Store<AppState> store) {
    final auth = store.state.auth;
    return _Vm(
      isLoading: auth.status == AuthStatus.loading,
      errorMessage: auth.errorMessage,
      onLogin: (email, pass) =>
          store.dispatch(LoginRequested(email: email, password: pass)),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Vm &&
          isLoading == other.isLoading &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hash(isLoading, errorMessage);
}
