import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../navigation/fade_page_route.dart';
import '../auth/sign_in_screen.dart';
import '../auth/sign_up_screen.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../shell/main_shell.dart';
import '../shell/main_shell.dart' show AppDrawer;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _imageController;
  late AnimationController _titleController;
  late AnimationController _buttonController;

  late Animation<double> _imageScale;
  late Animation<double> _titleSlide;
  late Animation<double> _buttonFade;

  @override
  void initState() {
    super.initState();

    _imageController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _imageScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.elasticOut),
    );
    _titleSlide = Tween<double>(begin: -50.0, end: 0.0).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeOutCubic),
    );
    _buttonFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _buttonController, curve: Curves.easeIn));

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _imageController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _titleController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _buttonController.forward();
  }

  @override
  void dispose() {
    _imageController.dispose();
    _titleController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n?.appTitle ?? 'Walter Shop')),
      drawer: AppDrawer(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Images with bounce animation
              AnimatedBuilder(
                animation: _imageScale,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _imageScale.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtjxKwYlTI634MqRZcNRwjPIAEvxpgMsD-_g&s',
                                width: 150,
                                height: 150,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                'assets/images/shop.jpg',
                                width: 150,
                                height: 150,
                                errorBuilder:
                                    (context, error, stack) => Container(
                                      width: 120,
                                      height: 120,
                                      color: Colors.grey.shade300,
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.image_not_supported,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Title with slide animation
              AnimatedBuilder(
                animation: _titleSlide,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _titleSlide.value),
                    child: Text(
                      l10n?.welcomeTitle ?? 'Welcome to the Shop',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.teal,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),

              // Buttons with fade animation
              AnimatedBuilder(
                animation: _buttonFade,
                builder: (context, child) {
                  return Opacity(
                    opacity: _buttonFade.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryButton(
                          icon: Icons.person_add,
                          label: l10n?.signUp ?? 'Sign Up',
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).push(FadePageRoute(page: const SignUpScreen()));
                          },
                        ),
                        const SizedBox(width: 16),
                        SecondaryButton(
                          icon: Icons.login,
                          label: l10n?.signIn ?? 'Sign In',
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).push(FadePageRoute(page: const SignInScreen()));
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
