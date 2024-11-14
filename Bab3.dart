import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Toko Bunga Denayra',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: const BerandaScreen(),
      );
}

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  _BerandaScreenState createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, String>> filteredBuketProducts;
  late List<Map<String, String>> filteredTanamanHiasProducts;

  final List<Map<String, String>> buketProducts = [
    {
      'name': 'Buket Biru Putih',
      'price': 'Rp 890.000',
      'image': 'assets/images/buket_biru.jpeg'
    },
    {
      'name': 'Buket Pink Royal',
      'price': 'Rp 950.000',
      'image': 'assets/images/buket_pink.jpeg'
    },
  ];

  final List<Map<String, String>> tanamanHiasProducts = [
    {
      'name': 'Tanaman Hias Aglaonema',
      'price': 'Rp 1.050.000',
      'image': 'assets/images/tanaman2.jpeg'
    },
    {
      'name': 'Tanaman Hias Anggrek',
      'price': 'Rp 2.180.000',
      'image': 'assets/images/tanaman1.jpeg'
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredBuketProducts = buketProducts;
    filteredTanamanHiasProducts = tanamanHiasProducts;
    _searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredBuketProducts = buketProducts
          .where((product) => product['name']!.toLowerCase().contains(query))
          .toList();
      filteredTanamanHiasProducts = tanamanHiasProducts
          .where((product) => product['name']!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Toko Bunga Denayra'),
          actions: const [Icon(Icons.shopping_cart), Icon(Icons.notifications)],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const _Header(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari Produk',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const _SpecialOffer(),
              const SizedBox(height: 16),
              _Section(title: 'Kategori', child: _CategoryList()),
              _Section(
                title: 'Buket',
                child: _ProductGrid(products: filteredBuketProducts),
              ),
              _Section(
                title: 'Tanaman Hias',
                child: _ProductList(products: filteredTanamanHiasProducts),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const _BottomNavBar(),
      );
}

// Header Section
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        color: Colors.deepPurple,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Lokasi: Ternate, Indonesia',
                style: TextStyle(color: Colors.white)),
            Row(
              children: [
                Icon(Icons.search, color: Colors.white),
                Icon(Icons.tune, color: Colors.white),
              ],
            ),
          ],
        ),
      );
}

class _SpecialOffer extends StatelessWidget {
  const _SpecialOffer();

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1596438459194-f275f413d6ff?q=80&w=1000&auto=format&fit=crop'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'Buket Bunga Diskon 20%',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
}

// Section Widget for organizing layout
class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 2, horizontal: 16), // Mengurangi padding vertikal
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4), // Mengurangi tinggi SizedBox
            child,
          ],
        ),
      );
}

// Category List (Horizontal Scroll)
class _CategoryList extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'name': 'Semua', 'image': 'assets/images/titik.jpeg'},
    {'name': 'Buket', 'image': 'assets/images/bunga_mawar.jpg'},
    {'name': 'Bunga', 'image': 'assets/images/bunga1.jpeg'},
    {'name': 'Tanaman Hias', 'image': 'assets/images/tanaman3.jpeg'},
  ];

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(category['image']!),
                    radius: 20,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category['name']!,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          },
        ),
      );
}

// Product Grid (for Buket products)
class _ProductGrid extends StatelessWidget {
  final List<Map<String, String>> products;

  const _ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => _ProductCard(
          product: products[index],
          isGrid: true,
        ),
      );
}

// Product List (for Tanaman Hias products)
class _ProductList extends StatelessWidget {
  final List<Map<String, String>> products;

  const _ProductList({required this.products});

  @override
  Widget build(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) => _ProductCard(
          product: products[index],
          isGrid: false,
        ),
      );
}

// Product Card with size adjustment based on layout
class _ProductCard extends StatelessWidget {
  final Map<String, String> product;
  final bool isGrid;

  const _ProductCard({required this.product, required this.isGrid});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
        ),
        child: Column(
          children: [
            Image.asset(
              product['image']!,
              height: isGrid ? 120 : 240, // Adjust height for Grid and List
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const FlutterLogo(),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product['price']!,
                    style: const TextStyle(color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Tambahkan logika aksi beli di sini
                    },
                    icon: const Icon(Icons.shopping_cart, color: Colors.white),
                    label: const Text(
                      "Beli Sekarang",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

// Bottom Navigation Bar
class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home, 'label': 'Beranda'},
      {'icon': Icons.explore, 'label': 'Jelajahi'},
      {'icon': Icons.favorite, 'label': 'Favorit'},
      {'icon': Icons.chat, 'label': 'Pesan'},
      {'icon': Icons.person, 'label': 'Profil'},
    ];
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      items: items
          .map((item) => BottomNavigationBarItem(
                icon: Icon(item['icon'] as IconData),
                label: item['label'] as String,
              ))
          .toList(),
    );
  }
}
