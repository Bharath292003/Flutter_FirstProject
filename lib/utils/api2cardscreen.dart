import 'package:flutter/material.dart';

import '../product_data_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // this is the coloumn
          children: [
            ListTile(
              title: Text(product.ProductName),
              subtitle: Text(
                  '${product.Quantity} '), // this is fetch the price from the api
            ),
          ],
        ),
      ),
    );
  }
}
