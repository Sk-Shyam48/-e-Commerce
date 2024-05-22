import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductCarousel extends StatelessWidget {
  final String productImage;

  const ProductCarousel({super.key, required this.productImage});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        NetworkImage(productImage),
      ].map((image) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(150),
              bottomRight: Radius.circular(150),
            ),
            image: DecorationImage(
              image: image,
              fit: BoxFit.contain,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        aspectRatio: 16 / 9,
      ),
    );
  }
}
