import '../models/product.dart';
import '../models/offer.dart';

// Featured carousel images (royalty-free Unsplash URLs)
const List<String> featuredImageUrls = [
  'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1600&auto=format&fit=crop', // Sneakers
  'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?q=80&w=1600&auto=format&fit=crop', // Watch
  'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?q=80&w=1600&auto=format&fit=crop', // Headphones
  'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=1600&auto=format&fit=crop', // Phone
  'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?q=80&w=1600&auto=format&fit=crop', // Camera
];

// Realistic products list
final List<ProductModel> productsData = [
  const ProductModel(
    title: 'Nike Air Max 270',
    imageUrl:
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1200&auto=format&fit=crop',
  ),
  const ProductModel(
    title: 'Apple AirPods Pro (2nd Gen)',
    imageUrl:
        'https://btech.com/media/catalog/product/cache/881019b77f15e434fc7c72c3f4366250/a/1/a106787461717e705385a80f7b60a1917760793a499e22df4825314be14d71a2.jpeg',
  ),
  const ProductModel(
    title: 'Samsung Galaxy Watch 6',
    imageUrl:
        'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?q=80&w=1200&auto=format&fit=crop',
  ),
  const ProductModel(
    title: 'Sony WH-1000XM5',
    imageUrl:
        'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?q=80&w=1200&auto=format&fit=crop',
  ),
  const ProductModel(
    title: 'Canon EOS R10 Mirrorless',
    imageUrl:
        'https://images.unsplash.com/photo-1519183071298-a2962be96f83?q=80&w=1200&auto=format&fit=crop',
  ),
  const ProductModel(
    title: 'Dell XPS 13 (2024)',
    imageUrl:
        'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?q=80&w=1200&auto=format&fit=crop',
  ),
  const ProductModel(
    title: 'Logitech MX Master 3S',
    imageUrl:
        'https://images.unsplash.com/photo-1587825140400-9d4b5b3a0277?q=80&w=1200&auto=format&fit=crop',
  ),
  const ProductModel(
    title: 'Kindle Paperwhite',
    imageUrl:
        'https://images.unsplash.com/photo-1513477967668-2aaf11838bd0?q=80&w=1200&auto=format&fit=crop',
  ),
  const ProductModel(
    title: 'Instant Pot Duo 7-in-1',
    imageUrl:
        'https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=1200&auto=format&fit=crop',
  ),
  const ProductModel(
    title: 'Adidas Ultraboost 22',
    imageUrl:
        'https://images.unsplash.com/photo-1529336953121-ad5a0d43d0d2?q=80&w=1200&auto=format&fit=crop',
  ),
  const ProductModel(
    title: 'Nintendo Switch OLED',
    imageUrl:
        'https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=1200&auto=format&fit=crop',
  ),
  const ProductModel(
    title: 'GoPro HERO12 Black',
    imageUrl:
        'https://images.unsplash.com/photo-1519183071298-a2962be96f83?q=80&w=1200&auto=format&fit=crop',
  ),
];

// Hot offers list
final List<OfferModel> offersData = [
  const OfferModel(
    imageUrl:
        'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?q=80&w=1200&auto=format&fit=crop',
    description: 'Summer Sale: Up to 50% off on top brands',
  ),
  const OfferModel(
    imageUrl:
        'https://images.unsplash.com/photo-1517705008128-361805f42e86?q=80&w=1200&auto=format&fit=crop',
    description: 'Smartwatch Week: Save big on wearables',
  ),
  const OfferModel(
    imageUrl:
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1200&auto=format&fit=crop',
    description: 'Audio Fest: Noise-cancelling headphones deals',
  ),
  const OfferModel(
    imageUrl:
        'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=1200&auto=format&fit=crop',
    description: 'Smartphone Bonanza: Exchange offers + Cashback',
  ),
  const OfferModel(
    imageUrl:
        'https://images.unsplash.com/photo-1526178611656-75d9c5c0f2f1?q=80&w=1200&auto=format&fit=crop',
    description: 'Cameras & Action: Lenses and accessories sale',
  ),
  const OfferModel(
    imageUrl:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=1200&auto=format&fit=crop',
    description: 'Weekend Deals: Extra 10% off with code WEEKEND',
  ),
];
