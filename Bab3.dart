import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toko Bunga',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const BerandaScreen(),
    );
  }
}

class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              const PencarianBar(),
              const PenawaranSpesial(),
              const Kategori(),
              const RekomendasiProduk(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavigasiBar(),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.deepPurple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Lokasi', style: TextStyle(color: Colors.white70)),
              Row(
                children: const [
                  Text('Jakarta, Indonesia',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white),
                ],
              ),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.shopping_cart_outlined, color: Colors.white),
              SizedBox(width: 16),
              Icon(Icons.notifications_outlined, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}

class PencarianBar extends StatelessWidget {
  const PencarianBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.deepPurple,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari bunga...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            ...[Icons.qr_code_scanner, Icons.tune].map((icon) => IconButton(
                icon: Icon(icon, color: Colors.grey), onPressed: () {})),
          ],
        ),
      ),
    );
  }
}

class PenawaranSpesial extends StatelessWidget {
  const PenawaranSpesial({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Penawaran Spesial', onPressed: () {}),
          const SizedBox(height: 8),
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1596438459194-f275f413d6ff?q=80&w=1000&auto=format&fit=crop',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
              ),
            ),
            child: const PositionedTextOverlay(),
          ),
        ],
      ),
    );
  }
}

class Kategori extends StatelessWidget {
  const Kategori({super.key});

  final List<String> categories = const [
    'Semua',
    'Buket',
    'Bunga',
    'Tanaman Hias'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Rekomendasi Untukmu', onPressed: () {}),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: categories
                  .map((category) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: FilterChip(
                          label: Text(category),
                          selected: category == 'Buket',
                          onSelected: (_) {},
                          backgroundColor: category == 'Buket'
                              ? Colors.deepPurple
                              : Colors.grey[200],
                          labelStyle: TextStyle(
                              color: category == 'Buket'
                                  ? Colors.white
                                  : Colors.black87),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class RekomendasiProduk extends StatelessWidget {
  const RekomendasiProduk({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Rekomendasi Produk',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Column(
            children: [
              ProdukCard(
                  imagePath: 'assets/images/buket_biru.jpeg',
                  name: 'Buket Biru Putih',
                  price: 'Rp 890.000'),
              const SizedBox(height: 16),
              ProdukCard(
                  imagePath: 'assets/images/buket_pink.jpeg',
                  name: 'Buket Pink Royal',
                  price: 'Rp 950.000'),
            ],
          ),
        ],
      ),
    );
  }
}

class NavigasiBar extends StatelessWidget {
  const NavigasiBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItemNavigasi(Icons.home_filled, 'Beranda', true),
          _buildItemNavigasi(Icons.explore_outlined, 'Jelajahi', false),
          _buildItemNavigasi(Icons.favorite_outline, 'Favorit', false),
          _buildItemNavigasi(Icons.chat_bubble_outline, 'Pesan', false),
          _buildItemNavigasi(Icons.person_outline, 'Profil', false),
        ],
      ),
    );
  }

  Widget _buildItemNavigasi(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isSelected ? Colors.deepPurple : Colors.grey),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                color: isSelected ? Colors.deepPurple : Colors.grey,
                fontSize: 12)),
      ],
    );
  }
}

class ProdukCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;

  const ProdukCard({
    required this.imagePath,
    required this.name,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          width: 150,
          height: 150,
          errorBuilder: (context, error, stackTrace) {
            return const Text(
              'Gambar tidak ditemukan!',
              style: TextStyle(color: Colors.red),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(price, style: const TextStyle(color: Colors.deepPurple)),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const SectionHeader(
      {required this.title, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextButton(onPressed: onPressed, child: const Text('Lihat Semua')),
      ],
    );
  }
}

class PositionedTextOverlay extends StatelessWidget {
  const PositionedTextOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 16,
      left: 16,
      child: Text(
        'Bunga Mawar Diskon 20%',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
