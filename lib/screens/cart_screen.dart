import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Keranjang')),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.shopping_cart, color: Colors.white),
          ),
          title: Text('Product $index'),
          subtitle: Text('Price: \$${20 + index}'),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
