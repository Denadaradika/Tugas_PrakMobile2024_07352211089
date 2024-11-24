import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Toko Denayra',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: const SplashScreen(),
      );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Menunggu selama 4 detik sebelum navigasi ke layar utama
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LayarUtama()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/images/logo.png', // Sesuaikan dengan lokasi gambar logo
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class Bunga {
  final String image;
  final String name;

  Bunga({
    required this.image,
    required this.name,
  });
}

final List<Bunga> bungaList = [
  Bunga(
    image: 'assets/images/bunga1.jpeg',
    name: 'Anggrek Pink',
  ),
  Bunga(
    image: 'assets/images/bunga2.jpeg',
    name: 'Mawar Putih',
  ),
  Bunga(
    image: 'assets/images/bunga3.jpeg',
    name: 'Lily Ungu',
  ),
  Bunga(
    image: 'assets/images/bunga4.jpeg',
    name: 'Tulip Biru',
  ),
];

class Produk {
  final String image;
  final String name;
  final double rating;
  final double price;

  Produk({
    required this.image,
    required this.name,
    required this.rating,
    required this.price,
  });
}

final List<Produk> produkList = [
  Produk(
    image: 'assets/images/buket_pink.jpeg',
    name: 'Buket Pink Royal',
    rating: 4.5,
    price: 63.33,
  ),
  Produk(
    image: 'assets/images/bunga_mawar.jpg',
    name: 'Buket Mawar Merah',
    rating: 4.7,
    price: 70.00,
  ),
  Produk(
    image: 'assets/images/tanaman2.jpeg',
    name: 'Tanaman Hias',
    rating: 4.6,
    price: 56.67,
  ),
];

class KeranjangScreen extends StatefulWidget {
  const KeranjangScreen({super.key});

  @override
  State<KeranjangScreen> createState() => _KeranjangScreenState();
}

class _KeranjangScreenState extends State<KeranjangScreen> {
  final Map<int, int> _jumlahProduk = {};

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < produkList.length; i++) {
      _jumlahProduk[i] = 1;
    }
  }

  void _deleteItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi hapus"),
          content: const Text("Apakah kamu yakin ingin menghapus item ini?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Tidak"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  produkList.removeAt(index);
                  _jumlahProduk.remove(index);
                });
                Navigator.of(context).pop(); // Close the dialog after deleting
              },
              child: const Text("Iya"),
            ),
          ],
        );
      },
    );
  }

  double _calculateSubtotal() {
    double total = 0;
    for (var i = 0; i < produkList.length; i++) {
      total += produkList[i].price * (_jumlahProduk[i] ?? 1);
    }
    return total;
  }

  double _calculateDeliveryCharges() {
    return 2.00; // Fixed delivery charge
  }

  double discount = 4.0;
  double deliveryCharges = 2.0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Cart"),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: produkList.length,
                itemBuilder: (context, index) {
                  final produk = produkList[index];
                  return Card(
                    elevation: 0,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            produk.image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                produk.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$${produk.price.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Delete button
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 20,
                              ),
                              onPressed: () => _deleteItem(index),
                            ),
                            // Quantity controls
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove,
                                      color: Colors.deepPurple,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if ((_jumlahProduk[index] ?? 1) > 1) {
                                          _jumlahProduk[index] =
                                              (_jumlahProduk[index] ?? 1) - 1;
                                        }
                                      });
                                    },
                                  ),
                                  Text(
                                    _jumlahProduk[index]
                                        .toString()
                                        .padLeft(2, '0'),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.deepPurple,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _jumlahProduk[index] =
                                            (_jumlahProduk[index] ?? 1) + 1;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Summary",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Items"),
                      Text("${produkList.length}"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Subtotal"),
                      Text("\$${_calculateSubtotal().toStringAsFixed(2)}"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Discount"),
                      Text("-\$${discount.toStringAsFixed(2)}"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Delivery Charges"),
                      Text(
                          "\$${_calculateDeliveryCharges().toStringAsFixed(2)}"),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${(_calculateSubtotal() - discount + _calculateDeliveryCharges()).toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Check Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class LayarUtama extends StatelessWidget {
  const LayarUtama({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const Icon(Icons.menu, color: Colors.black),
          title: Row(
            children: [
              // Membuat gambar logo berbentuk bulat
              ClipOval(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Toko Denayra',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon:
                  const Icon(Icons.notifications_outlined, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon:
                  const Icon(Icons.shopping_cart_outlined, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const KeranjangScreen()),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bangunBarPencarian(),
              _bangunBannerPromo(),
              _bangunSeksiTeratas(),
              _bangunPesananTerbaik(),
              _bangunBannerPromo2(),
              _bangunPromoDetail(),
              _bangunWorkshopDisarankan(),
            ],
          ),
        ),
        bottomNavigationBar: _bangunNavigasiBawah(),
      );

  Widget _bangunBarPencarian() => Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Cari di sini',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
      );

  Widget _bangunBannerPromo() => Container(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 248, 175, 242),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today\'s Deal',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '50% OFF',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const Text(
                      'Beli sekarang dan dapatkan diskon spesial!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 46, 45, 45),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('BUY IT NOW'),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/promo1.jpeg',
                width: 250,
                height: 150,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      );

  Widget _bangunSeksiTeratas() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bangunJudulSeksi('Bunga Terpopuler'),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: bungaList.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final bunga = bungaList[index];
                return _bangunKartuBunga(bunga);
              },
            ),
          ),
        ],
      );
  Widget _bangunPesananTerbaik() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bangunJudulSeksi('Pembelian Terbaik'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: produkList.map((produk) {
                return Column(
                  children: [
                    _bangunKartuPesanan(produk),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      );
  Widget _bangunJudulSeksi(String judul) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              judul,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Lihat Semua'),
            ),
          ],
        ),
      );

  Widget _bangunKartuBunga(Bunga bunga) => Container(
        width: 120,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                bunga.image,
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bunga.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text('4.5'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _bangunKartuLayanan() => Card(
        child: ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/tatabunga.jpeg'),
          ),
          title: const Text('Penataan Bunga'),
          subtitle: const Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 16),
              Text('4.5'),
            ],
          ),
          trailing: ElevatedButton(
            onPressed: () {},
            child: const Text('Pesan Sekarang'),
          ),
        ),
      );

  Widget _bangunKartuPesanan(Produk produk) => Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Bagian kiri: gambar besar dengan layer keterangan di atasnya
              Expanded(
                flex: 2, // Mengatur agar gambar lebih lebar
                child: Stack(
                  children: [
                    // Layer gambar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        produk.image,
                        width: 300, // Lebar gambar
                        height: 160, // Tinggi gambar
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Layer keterangan di atas gambar (hanya menutupi sebagian)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        width: 200, // Lebar layer keterangan yang lebih kecil
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Rata kiri untuk keterangan
                          children: [
                            // Row untuk gambar profil dan nama produk
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 20, // Ukuran gambar profil
                                  backgroundImage: AssetImage(
                                      'assets/images/profil.jpeg'), // Ganti dengan path gambar profil
                                ),
                                const SizedBox(width: 8),
                                // Teks nama produk di sebelah gambar profil
                                Expanded(
                                  child: Text(
                                    produk.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 255, 254, 254),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            // Rating
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  '${produk.rating}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Harga produk
                            Text(
                              'Rp ${produk.price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 253, 253),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Tombol Pesan Sekarang
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Pesan Sekarang',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _bangunBannerPromo2() => Container(
        width: double.infinity,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 157, 124, 214),
              Color.fromARGB(255, 157, 124, 214)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/promo2.jpeg',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Diskon 60%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                    ),
                    child: const Text('Beli Sekarang'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _bangunPromoDetail() => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pelayanan Terbaik',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: List.generate(2, (index) => _bangunKartuBooking()),
            ),
          ],
        ),
      );

  Widget _bangunKartuBooking() => Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                'assets/images/best.jpg',
                width: double.infinity,
                height: 180, // Sesuaikan tinggi gambar
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/profil.jpeg'),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Miss Denayra',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Florist in Indonesia',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text('4.9'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _bangunWorkshopDisarankan() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bangunJudulSeksi('Workshop Direkomendasikan'),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 4,
            itemBuilder: (context, index) => _bangunKartuWorkshop(),
          ),
        ],
      );
  Widget _bangunKartuWorkshop() => Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: const AssetImage('assets/images/workshop.jpeg'),
                  fit: BoxFit.cover, // Pastikan gambar terisi penuh
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Workshop Merangkai Bunga',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text('4.5'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8), // Lebih tinggi
                      ),
                      child: const Text(
                        'Pesan Workshop',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _bangunNavigasiBawah() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cari'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.book_online), label: 'blog'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
      );
}
