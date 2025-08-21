import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../navigation/fade_page_route.dart';
import '../auth/sign_in_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _avatarController;
  late AnimationController _infoController;
  late AnimationController _buttonController;

  late Animation<double> _avatarScale;
  late Animation<double> _infoSlide;
  late Animation<double> _buttonFade;

  @override
  void initState() {
    super.initState();

    _avatarController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _infoController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _avatarScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _avatarController, curve: Curves.elasticOut),
    );
    _infoSlide = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _infoController, curve: Curves.easeOutCubic),
    );
    _buttonFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _buttonController, curve: Curves.easeIn));

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _avatarController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _infoController.forward();
    await Future.delayed(const Duration(milliseconds: 150));
    _buttonController.forward();
  }

  @override
  void dispose() {
    _avatarController.dispose();
    _infoController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final l10n = AppLocalizations.of(context);
    final name = appState.userName ?? 'Guest';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar with bounce animation
          AnimatedBuilder(
            animation: _avatarScale,
            builder: (context, child) {
              return Transform.scale(
                scale: _avatarScale.value,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.teal,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AnimatedBuilder(
                        animation: _infoSlide,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(_infoSlide.value, 0),
                            child: Text(
                              name,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // Buttons with fade animation
          AnimatedBuilder(
            animation: _buttonFade,
            builder: (context, child) {
              return Opacity(
                opacity: _buttonFade.value,
                child: Column(
                  children: [
                    if (appState.userName != null) ...[
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.logout),
                          onPressed: () {
                            context.read<AppState>().setUserName(null);
                            context.read<AppState>().clearCart();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n?.loggedOut ?? 'Logged out'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          },
                          label: Text(l10n?.logout ?? 'Logout'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade50,
                            foregroundColor: Colors.red.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.login),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              FadePageRoute(page: const SignInScreen()),
                              (route) => false,
                            );
                          },
                          label: Text(l10n?.signIn ?? 'Sign In'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal.shade50,
                            foregroundColor: Colors.teal.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
