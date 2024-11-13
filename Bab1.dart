import 'dart:async';

class User {
  String name;
  int age;
  late List<Product> products;
  Role? role;

  User(this.name, this.age) {
    products = []; // Inisialisasi list kosong untuk products
  }

  void viewProducts() {
    if (products.isNotEmpty) {
      print("Daftar Produk untuk $name:");
      for (var product in products) {
        print("- ${product}");
      }
    } else {
      print("Tidak ada produk yang tersedia untuk $name.");
    }
  }
}

class Product {
  String productName;
  double price;
  bool inStock;

  Product(this.productName, this.price, this.inStock);

  @override
  String toString() {
    return "Nama Produk: $productName, Harga: Rp${price.toStringAsFixed(2)}, Status: ${inStock ? 'Tersedia' : 'Habis'}";
  }
}

enum Role { Admin, Customer }

class AdminUser extends User {
  AdminUser(super.name, super.age) {
    role = Role.Admin;
  }

  void addProduct(Product product) {
    if (product.inStock) {
      products.add(product);
      print("Produk '${product.productName}' berhasil ditambahkan.");
    } else {
      print("Produk '${product.productName}' sudah habis.");
    }
  }

  void removeProduct(Product product) {
    if (products.contains(product)) {
      products.remove(product);
      print("Produk '${product.productName}' berhasil dihapus.");
    } else {
      print("Produk '${product.productName}' tidak ditemukan dalam daftar.");
    }
  }
}

class CustomerUser extends User {
  CustomerUser(super.name, super.age) {
    role = Role.Customer;
  }
}

void addProductSafely(AdminUser admin, Product product) {
  try {
    if (!product.inStock) {
      throw Exception("Produk '${product.productName}' sudah habis.");
    }
    admin.addProduct(product);
  } catch (e) {
    print("Error: $e");
  }
}

Future<void> fetchProductDetails(Product product) async {
  print("Mengambil detail untuk produk '${product.productName}'...");
  await Future.delayed(const Duration(seconds: 2));
  print("Detail produk '${product.productName}' berhasil diambil.");
}

void main() {
  Product p1 = Product("Laptop", 15000.0, true);
  Product p2 = Product("Smartphone", 7000.0, false);
  Product p3 = Product("Headphones", 2000.0, true);

  Map<String, Product> productCatalog = {
    p1.productName: p1,
    p2.productName: p2,
    p3.productName: p3,
  };
  productCatalog.forEach((key, product) {
    print("$product");
  });

  Set<Product> uniqueProducts = {p1, p2, p3};
  if (uniqueProducts.contains(p1)) {
    print("${p1.productName} ditemukan di uniqueProducts.");
  }
  AdminUser admin = AdminUser("Denada", 30);
  CustomerUser customer = CustomerUser("Radika", 25);

  addProductSafely(admin, p1);
  addProductSafely(
      admin, p2); // Produk ini akan memicu exception karena stok habis

  customer.products = admin.products;
  customer.viewProducts();

  fetchProductDetails(p1);
}
