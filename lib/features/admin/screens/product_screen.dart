import 'package:amazon_clone_nodejs/features/admin/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Products'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add a product',
        onPressed: () {
          Navigator.pushNamed(context, AddProductScreen.routeName);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
