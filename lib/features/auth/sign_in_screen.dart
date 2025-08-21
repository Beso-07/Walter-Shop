import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../navigation/fade_page_route.dart';
import '../shell/main_shell.dart';
import '../../widgets/textfields/validated_text_field.dart';
import '../../widgets/buttons/primary_button.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late AnimationController _emailController;
  late AnimationController _passwordController;
  late AnimationController _buttonController;

  late Animation<double> _emailSlide;
  late Animation<double> _passwordSlide;
  late Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();

    _emailController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _passwordController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _emailSlide = Tween<double>(begin: -100.0, end: 0.0).animate(
      CurvedAnimation(parent: _emailController, curve: Curves.easeOutCubic),
    );
    _passwordSlide = Tween<double>(begin: -100.0, end: 0.0).animate(
      CurvedAnimation(parent: _passwordController, curve: Curves.easeOutCubic),
    );
    _buttonScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.elasticOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _emailController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _passwordController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _buttonController.forward();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n?.signIn ?? 'Sign In')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Email field with slide animation
                AnimatedBuilder(
                  animation: _emailSlide,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_emailSlide.value, 0),
                      child: ValidatedTextField(
                        controller: emailController,
                        labelText: l10n?.email ?? 'Email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          final text = value?.trim() ?? '';
                          if (text.isEmpty) {
                            return l10n?.errRequired ?? 'Required';
                          }
                          if (!text.contains('@')) {
                            return l10n?.errEmail ?? 'Must include @';
                          }
                          return null;
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),

                // Password field with slide animation
                AnimatedBuilder(
                  animation: _passwordSlide,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_passwordSlide.value, 0),
                      child: ValidatedTextField(
                        controller: passwordController,
                        labelText: l10n?.password ?? 'Password',
                        obscureText: true,
                        validator: (value) {
                          final text = value ?? '';
                          if (text.length < 6) {
                            return l10n?.errPasswordLen ??
                                'At least 6 characters';
                          }
                          return null;
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Submit button with scale animation
                AnimatedBuilder(
                  animation: _buttonScale,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _buttonScale.value,
                      child: PrimaryButton(
                        icon: Icons.login,
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: Text(l10n?.success ?? 'Success'),
                                    content: Text(
                                      l10n?.accountSignIn ??
                                          'Account sign-in successfully',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          final email =
                                              emailController.text.trim();
                                          final name = email.split('@').first;
                                          context.read<AppState>().setUserName(
                                            name,
                                          );
                                          Navigator.of(
                                            context,
                                          ).pushAndRemoveUntil(
                                            FadePageRoute(
                                              page: const MainShell(),
                                            ),
                                            (route) => false,
                                          );
                                        },
                                        child: Text(l10n?.close ?? 'Close'),
                                      ),
                                    ],
                                  ),
                            );
                          }
                        },
                        label: l10n?.submit ?? 'Submit',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
