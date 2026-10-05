import 'package:flutter/material.dart';
import 'services/product_service.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: QuickShopPage(),
  ));
}

class QuickShopPage extends StatelessWidget {
  QuickShopPage({super.key});

  final ProductService _service = ProductService();

  @override
  Widget build(BuildContext context) {
    // Chỉ lấy kết quả đã lọc
    final products = _service.filterByMaxPrice(100);
    
    // Yêu cầu mở rộng Level 2: Tính tổng tiền
    final totalPrice = _service.calculateTotalPrice(products);
    print("Tổng tiền các sản phẩm hiển thị: \$${totalPrice}");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sản phẩm giá rẻ (< 100\$)"),
      ),
      body: ListView(
        children: products.map((product) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              // Yêu cầu mở rộng Level 3: Dùng Image.network
              leading: Image.network(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(product.name),
              subtitle: Text("\$${product.price}"),
              trailing: const Icon(Icons.add_shopping_cart),
              onTap: () => _service.handleAddToCart(product),
            ),
          );
        }).toList(),
      ),
    );
  }
}
