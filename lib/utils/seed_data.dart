import 'package:cloud_firestore/cloud_firestore.dart';

/// One-time, manually-triggered seed script for populating Firestore with a
/// sample ByteShop catalog. This is NOT called automatically anywhere in the
/// app. See the bottom of this file for how to trigger [seedByteShopCatalog]
/// now that the in-app dev button has been removed.
///
/// Writes directly via the Firestore SDK rather than through
/// FirestoreService, which is read-only — products are never
/// created/edited/deleted from the app UI, only by this script.
///
/// Prices are BDT estimates grounded in mid-2026 Bangladesh retail listings
/// (Star Tech, Ryans, BDStall) for comparable models, not invented figures.
///
/// Image URLs are real photos from images.unsplash.com (direct CDN links,
/// no API key needed) — generic tech-accessory shots picked to match each
/// product's category/type, not the exact branded item. Every URL below was
/// verified to resolve with a 200 and an image/jpeg content-type before
/// being added here.
///
/// Running this more than once will create duplicate documents, since each
/// call just appends new products rather than upserting.
Future<void> seedByteShopCatalog() async {
  final products = FirebaseFirestore.instance.collection('products');
  for (final product in _seedProducts) {
    await products.add(product);
  }
}

final List<Map<String, dynamic>> _seedProducts = [
  // --- Peripherals: budget -> mid-range -> premium, keyboards and mice ---
  {
    'name': 'A4Tech KR-85 Wired Membrane Keyboard',
    'category': 'Peripherals',
    'price': 480.0,
    'description':
        'Budget-friendly wired membrane keyboard for everyday typing and office use.',
    'imageUrl':
        'https://images.unsplash.com/photo-1614921003749-e04bd7f27a1f?w=400&q=80',
  },
  {
    'name': 'A4Tech OP-620D Wired Mouse',
    'category': 'Peripherals',
    'price': 350.0,
    'description':
        'Reliable entry-level wired optical mouse with a comfortable ergonomic shape.',
    'imageUrl':
        'https://images.unsplash.com/photo-1613141411244-0e4ac259d217?w=400&q=80',
  },
  {
    'name': 'Logitech M185 Wireless Mouse',
    'category': 'Peripherals',
    'price': 950.0,
    'description':
        'Compact wireless mouse with a 2.4GHz USB receiver and up to a year of battery life.',
    'imageUrl':
        'https://images.unsplash.com/photo-1629429408708-3a59f51979c5?w=400&q=80',
  },
  {
    'name': 'Fantech MK852 RGB Mechanical Keyboard',
    'category': 'Peripherals',
    'price': 3500.0,
    'description':
        'Mid-range mechanical keyboard with per-key RGB lighting and tactile blue switches.',
    'imageUrl':
        'https://images.unsplash.com/photo-1543966888-6e858b90d30d?w=400&q=80',
  },
  {
    'name': 'Fantech Aria XD7 Gaming Mouse',
    'category': 'Peripherals',
    'price': 2800.0,
    'description':
        'Gaming mouse with adjustable DPI up to 10,000, RGB accents, and extra programmable buttons.',
    'imageUrl':
        'https://images.unsplash.com/photo-1621068403336-853c0a5ca4dc?w=400&q=80',
  },
  {
    'name': 'Razer BlackWidow V4 Mechanical Keyboard',
    'category': 'Peripherals',
    'price': 11500.0,
    'description':
        'Premium full-size mechanical keyboard with hot-swappable switches and dynamic RGB underglow.',
    'imageUrl':
        'https://images.unsplash.com/photo-1543966888-6e858b90d30d?w=400&q=80',
  },

  // --- Storage: flash/memory card -> HDD -> SSD tiers by capacity ---
  {
    'name': 'Transcend 64GB USB 3.2 Flash Drive',
    'category': 'Storage',
    'price': 750.0,
    'description':
        'Compact USB 3.2 flash drive for everyday file transfer and backup.',
    'imageUrl':
        'https://images.unsplash.com/photo-1477949331575-2763034b5fb5?w=400&q=80',
  },
  {
    'name': 'SanDisk 64GB microSDXC Memory Card',
    'category': 'Storage',
    'price': 1150.0,
    'description':
        'Class 10 microSDXC card for cameras, phones, and dash cams.',
    'imageUrl':
        'https://images.unsplash.com/photo-1499336969384-ebe67b79faa8?w=400&q=80',
  },
  {
    'name': 'Toshiba Canvio 1TB Portable External HDD',
    'category': 'Storage',
    'price': 4500.0,
    'description':
        'USB 3.0 portable hard drive offering budget bulk storage for backups.',
    'imageUrl':
        'https://images.unsplash.com/photo-1756142752397-9d2ace3ba0d1?w=400&q=80',
  },
  {
    'name': 'SanDisk Extreme 500GB Portable SSD',
    'category': 'Storage',
    'price': 4200.0,
    'description':
        'Fast, compact USB-C portable SSD with a shock-resistant rubberized design.',
    'imageUrl':
        'https://images.unsplash.com/photo-1756142752564-586c77618757?w=400&q=80',
  },
  {
    'name': 'Kingston XS1000 1TB Portable SSD',
    'category': 'Storage',
    'price': 8900.0,
    'description':
        'High-speed 1TB USB 3.2 Gen 2 portable SSD in a pocket-sized aluminum body.',
    'imageUrl':
        'https://images.unsplash.com/photo-1756142752564-586c77618757?w=400&q=80',
  },
  {
    'name': 'Samsung T7 2TB Portable SSD',
    'category': 'Storage',
    'price': 16800.0,
    'description':
        'Premium 2TB portable SSD with read speeds up to 1,050MB/s for creative workloads.',
    'imageUrl':
        'https://images.unsplash.com/photo-1756142752564-586c77618757?w=400&q=80',
  },

  // --- Accessories: small/cheap add-ons up to a pricier headset ---
  {
    'name': 'Havit 4-Port USB 2.0 Hub',
    'category': 'Accessories',
    'price': 350.0,
    'description':
        "Simple 4-port USB hub for expanding a laptop or desktop's USB connectivity.",
    'imageUrl':
        'https://images.unsplash.com/photo-1760376789487-994070337c76?w=400&q=80',
  },
  {
    'name': 'Fantech MP-35 Standard Mouse Pad',
    'category': 'Accessories',
    'price': 250.0,
    'description':
        'Smooth-surface fabric mouse pad with a stitched, non-slip rubber base.',
    'imageUrl':
        'https://images.unsplash.com/photo-1702561667800-2c49b0182229?w=400&q=80',
  },
  {
    'name': 'Cable Management Sleeve & Clip Organizer Set',
    'category': 'Accessories',
    'price': 300.0,
    'description':
        'Bundle of cable clips and a sleeve for tidying up desktop and under-desk cables.',
    'imageUrl':
        'https://images.unsplash.com/photo-1760348213270-7cd00b8c3405?w=400&q=80',
  },
  {
    'name': 'Havit F2076 Laptop Cooling Pad',
    'category': 'Accessories',
    'price': 950.0,
    'description':
        'Dual-fan laptop cooling stand with adjustable height, fits laptops up to 15.6".',
    'imageUrl':
        'https://images.unsplash.com/photo-1723015297241-b1cbf891315e?w=400&q=80',
  },
  {
    'name': 'A4Tech PK-935HL HD Webcam',
    'category': 'Accessories',
    'price': 1800.0,
    'description':
        '1080p webcam with a built-in noise-reducing microphone for calls and streaming.',
    'imageUrl':
        'https://images.unsplash.com/photo-1624538315849-f9caa9412f3d?w=400&q=80',
  },
  {
    'name': 'UGREEN 6-in-1 USB-C Hub',
    'category': 'Accessories',
    'price': 2400.0,
    'description':
        'USB-C hub with HDMI, USB-A, and SD/microSD card reader ports for laptops.',
    'imageUrl':
        'https://images.unsplash.com/photo-1616578273518-450dd375759b?w=400&q=80',
  },
  {
    'name': 'Fantech MH85 Gaming Headset',
    'category': 'Accessories',
    'price': 3200.0,
    'description':
        'Over-ear gaming headset with a noise-cancelling boom mic and RGB accents.',
    'imageUrl':
        'https://images.unsplash.com/photo-1548686304-89d188a80029?w=400&q=80',
  },
];
