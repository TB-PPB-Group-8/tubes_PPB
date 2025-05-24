import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Map<int, bool> selectedItems = {};
  bool isAllSelected = false;

  AppBar buildGradientAppBar(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      title: Text(
        'Keranjang',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.deepOrange.shade700, Colors.pink.shade900]
                : [Colors.orangeAccent, Colors.pinkAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      elevation: 0,
    );
  }

  String formatPrice(double price) {
    final formatter = NumberFormat.simpleCurrency(locale: 'en_US');
    return formatter.format(price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildGradientAppBar(context),
      body: Consumer<CartController>(
        builder: (context, cartController, child) {
          if (cartController.cartItems.isEmpty) {
            return Center(child: Text('Keranjang Anda kosong.'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: cartController.cartItems.length,
                  separatorBuilder: (context, index) => Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = cartController.cartItems[index];
                    selectedItems.putIfAbsent(index, () => false);

                    return ListTile(
                      leading: Checkbox(
                        value: selectedItems[index],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedItems[index] = value ?? false;
                            isAllSelected =
                                selectedItems.values.every((v) => v);
                          });
                        },
                      ),
                      title: Row(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(item.product['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product['title'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${formatPrice(item.product['price'] * item.quantity)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.red),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.delete,
                                          color: Colors.grey),
                                      onPressed: () {
                                        cartController.removeItem(index);
                                        setState(() {
                                          selectedItems.remove(index);
                                          isAllSelected = selectedItems.values
                                              .every((v) => v);
                                        });
                                      },
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.remove_circle_outline),
                                      onPressed: () {
                                        cartController
                                            .decreaseItemQuantity(index);
                                      },
                                    ),
                                    Text('${item.quantity}',
                                        style: TextStyle(fontSize: 16)),
                                    IconButton(
                                      icon: Icon(Icons.add_circle_outline),
                                      onPressed: () {
                                        cartController
                                            .increaseItemQuantity(index);
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Divider(height: 1),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Checkbox(
                      value: isAllSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          isAllSelected = value ?? false;
                          selectedItems.updateAll((key, _) => isAllSelected);
                        });
                      },
                    ),
                    const Text('Semua'),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        'Total: ${formatPrice(selectedItems.entries.where((e) => e.value).fold(0.0, (sum, e) {
                          final item = cartController.cartItems[e.key];
                          return sum + item.product['price'] * item.quantity;
                        }))}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final selectedIndices = selectedItems.entries
                            .where((e) => e.value)
                            .map((e) => e.key)
                            .toList();
                        if (selectedIndices.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Pilih barang terlebih dahulu')),
                          );
                          return;
                        }
                        // TODO: proses beli barang terpilih
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Beli', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
