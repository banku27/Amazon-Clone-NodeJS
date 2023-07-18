import 'package:amazon_clone_nodejs/common/loader.dart';
import 'package:amazon_clone_nodejs/features/admin/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../account/widgets/single_product.dart';
import '../services/admin_services.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  AdminServices adminServices = AdminServices();
  List<Product>? products = [];
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Scaffold(
              body: GridView.builder(
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.5 / 2, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 180,
                        child: SingleProduct(
                          image: productData.images[0],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                productData.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete_outline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),
          );
  }
}
