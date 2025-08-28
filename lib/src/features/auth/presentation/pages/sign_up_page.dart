import 'package:flutter/material.dart';
import 'package:login_app/src/shared/widgets/app_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Register', style: theme.textTheme.headlineLarge),
              Text(
                'Please create an account',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: "Enter your email",
                controller: TextEditingController(),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: "Enter your password",
                controller: TextEditingController(),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: "Confirm your password",
                controller: TextEditingController(),
                obscureText: true,
              ),
              const SizedBox(height: 26),
              ElevatedButton(onPressed: () {}, child: Text('Sign Up')),
              const SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }
}
