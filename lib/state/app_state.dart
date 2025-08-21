import 'package:flutter/material.dart';
import '../features/home/models/product.dart';

class AppState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');
  final List<ProductModel> _cart = <ProductModel>[];
  String? _userName;

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  List<ProductModel> get cart => List.unmodifiable(_cart);
  String? get userName => _userName;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleLocale() {
    _locale = _locale.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _cart.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void setUserName(String? name) {
    _userName = name;
    notifyListeners();
  }
}


