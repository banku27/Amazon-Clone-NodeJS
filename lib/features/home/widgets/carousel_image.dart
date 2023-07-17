import 'package:amazon_clone_nodejs/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages
          .map(
            (i) => Builder(builder: (BuildContext context) => Image.network(i)),
          )
          .toList(),
      options: CarouselOptions(
        animateToClosest: true,
        autoPlay: true,
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}
