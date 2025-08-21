# Walter Shop – Flutter Shopping App

This project implements a complete shopping app with welcome, authentication, and shopping home screens, plus Arabic localization.

## Features
- Walter welcome screen with title AppBar, a row of images (local + online), and buttons for Sign Up / Sign In
- Sign-Up form: Full name, email, password, confirm password with validation and success dialog
- Sign-In form: Email and password with validation and success dialog
- Smooth fade transitions between pages
- Shopping Home screen:
  - AppBar titled "Our Products" (localized)
  - Featured images in a PageView (horizontal)
  - Product GridView (2 per row) with add-to-cart SnackBar
  - Hot Offers section using ListView.builder with images and descriptions
- Arabic localization (.arb with `intl` and Flutter localization)
- Modular code structure (widgets in folders like `widgets/textfields`, screens under `features/...`)

## Project Structure
- `lib/main.dart`: App entry, theme, localization, home route
- `lib/navigation/fade_page_route.dart`: Reusable fade transition route
- `lib/features/welcome/welcome_screen.dart`: Walter welcome UI
- `lib/features/auth/sign_up_screen.dart`: Sign-Up form and validation
- `lib/features/auth/sign_in_screen.dart`: Sign-In form and validation
- `lib/features/home/home_screen.dart`: Shopping Home screen
- `lib/widgets/textfields/validated_text_field.dart`: Reusable validated text field
- `lib/l10n/app_en.arb`, `lib/l10n/app_ar.arb`: Localization resources

## Setup
1. Install Flutter SDK
2. From project root:
```bash
flutter pub get
flutter gen-l10n
flutter run
```

