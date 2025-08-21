import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  late AnimationController _emptyController;
  late Animation<double> _emptyScale;
  late Animation<double> _emptyRotate;

  @override
  void initState() {
    super.initState();
    _emptyController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _emptyScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _emptyController, curve: Curves.elasticOut),
    );
    _emptyRotate = Tween<double>(begin: -0.1, end: 0.0).animate(
      CurvedAnimation(parent: _emptyController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _emptyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final l10n = AppLocalizations.of(context);
    final items = appState.cart;

    if (items.isEmpty) {
      _emptyController.forward();
      return AnimatedBuilder(
        animation: _emptyController,
        builder: (context, child) {
          return Center(
            child: Transform.scale(
              scale: _emptyScale.value,
              child: Transform.rotate(
                angle: _emptyRotate.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 60,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n?.cartEmpty ?? 'Cart is empty',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add some products to get started!',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = items[index];
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 200 + (index * 100)),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset((1 - value) * 100, 0),
              child: Opacity(opacity: value, child: child),
            );
          },
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: Hero(
                tag: 'cart_${item.title}',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.imageUrl,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (c, e, s) => Container(
                            width: 56,
                            height: 56,
                            color: Colors.grey.shade300,
                            alignment: Alignment.center,
                            child: const Icon(Icons.image, size: 24),
                          ),
                    ),
                  ),
                ),
              ),
              title: Text(
                item.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text('Tap to remove'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  context.read<AppState>().removeFromCart(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.title} removed from cart'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed:
                            () => context.read<AppState>().addToCart(item),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
