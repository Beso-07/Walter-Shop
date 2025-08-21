import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'features/shell/main_shell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      fontFamily: 'Suwannaphum',
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      useMaterial3: true,
    );

    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: Builder(
        builder: (context) {
          final appState = context.watch<AppState>();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Walter Shop',
            theme: baseTheme.copyWith(
              brightness: Brightness.light,
              colorScheme: baseTheme.colorScheme.copyWith(
                primary: Colors.teal,
                secondary: Colors.orange,
                surface: const Color(0xFFFAFAFA),
              ),
              scaffoldBackgroundColor: const Color(0xFFF1F5F4),
              textTheme: GoogleFonts.suwannaphumTextTheme(baseTheme.textTheme),
              appBarTheme: baseTheme.appBarTheme.copyWith(centerTitle: true),
              filledButtonTheme: FilledButtonThemeData(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.teal,
                  side: const BorderSide(color: Colors.teal),
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Colors.teal,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
              ),
              cardTheme: const CardTheme(color: Colors.white),
            ),
            darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.teal,
                brightness: Brightness.dark,
              ),
              textTheme: GoogleFonts.suwannaphumTextTheme(
                ThemeData.dark().textTheme,
              ),
              filledButtonTheme: FilledButtonThemeData(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.teal,
                  side: BorderSide(color: Colors.teal.shade200),
                ),
              ),
            ),
            themeMode: appState.themeMode,
            locale: appState.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('ar')],
            home: const WelcomeScreen(),
            routes: {'/main': (_) => const MainShell()},
          );
        },
      ),
    );
  }
}
