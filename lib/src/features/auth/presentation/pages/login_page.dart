import 'package:flutter/material.dart';
import 'package:login_app/src/app/presentation/routes.dart';
import 'package:login_app/src/shared/widgets/app_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Login', style: theme.textTheme.headlineLarge),
              Text(
                'Please login to your account',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              AppTextField(label: "Email", controller: TextEditingController()),
              const SizedBox(height: 26),
              AppTextField(
                label: "Password",
                controller: TextEditingController(),
                obscureText: true,
              ),
              const SizedBox(height: 26),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.home);
                },
                child: Text('Login'),
              ),
              const SizedBox(height: 26),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.register);
                },
                child: Text.rich(
                  TextSpan(
                    style: theme.textTheme.bodyMedium,
                    children: [
                      TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: "Sign up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
