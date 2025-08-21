import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'models/product.dart';
import 'models/offer.dart';
import 'data/sample_data.dart';
import 'widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _featuredController;
  late AnimationController _productsController;
  late AnimationController _offersController;

  late Animation<double> _featuredSlide;
  late Animation<double> _productsScale;
  late Animation<double> _offersFade;

  @override
  void initState() {
    super.initState();

    _featuredController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _productsController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _offersController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _featuredSlide = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(parent: _featuredController, curve: Curves.easeOutCubic),
    );
    _productsScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _productsController, curve: Curves.elasticOut),
    );
    _offersFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _offersController, curve: Curves.easeIn));

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _featuredController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _productsController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _offersController.forward();
  }

  @override
  void dispose() {
    _featuredController.dispose();
    _productsController.dispose();
    _offersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final List<String> featuredImages = featuredImageUrls;
    final List<ProductModel> products = productsData;
    final List<OfferModel> offers = offersData;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Featured images with slide animation
        AnimatedBuilder(
          animation: _featuredSlide,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _featuredSlide.value),
              child: SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.9),
                  itemCount: featuredImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            featuredImages[index],
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stack) => Container(
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.image_not_supported),
                                ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        // Products grid with scale animation
        AnimatedBuilder(
          animation: _productsScale,
          builder: (context, child) {
            return Transform.scale(
              scale: _productsScale.value,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return InkWell(
                    onTap: () {},
                    child: ProductCard(product: product),
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(height: 20),

        // Hot offers with fade animation
        AnimatedBuilder(
          animation: _offersFade,
          builder: (context, child) {
            return Opacity(
              opacity: _offersFade.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n?.hotOffers ?? 'Hot Offers',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: offers.length,
                    itemBuilder: (context, index) {
                      final offer = offers[index];
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 300 + (index * 100)),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset((1 - value) * 50, 0),
                            child: Opacity(opacity: value, child: child),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    offer.imageUrl,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stack) => Container(
                                          width: 100,
                                          height: 100,
                                          color: Colors.grey.shade300,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.image_not_supported,
                                          ),
                                        ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(child: Text(offer.description)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
