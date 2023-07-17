import 'package:amazon_clone_nodejs/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List list = [
    "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/macbook-air-midnight-config-20220606?wid=820&hei=498&fmt=jpeg&qlt=90&.v=1654122880566",
    "https://ezone-electronics.online/wp-content/uploads/2020/12/71zny7BTRlL._SL1500_.jpg",
    "data:image/jpeg;base64,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"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: const Text(
                'Your Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child: Text(
                'See all',
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),
        // display orders
        Container(
          height: 170,
          padding: const EdgeInsets.only(
            left: 10,
            top: 20,
            right: 0,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: SingleProduct(image: list[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
