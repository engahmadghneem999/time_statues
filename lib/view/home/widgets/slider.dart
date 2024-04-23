import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class SliderL extends StatefulWidget {
  const SliderL({Key? key}) : super(key: key);

  @override
  State<SliderL> createState() => _SliderLState();
}

class _SliderLState extends State<SliderL> {
  int activeIndex = 0;
  final slider = [
    'assets/images/coins1.jpeg',
    'assets/images/coins2.jpeg',
    'assets/images/coins3.jpeg',
    'assets/images/coins4.jpeg',

  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: slider.length,
        itemBuilder: (context, index, realIndex) {
          final sliders = slider[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildImage(sliders, index),
          );
        },
        options: CarouselOptions(
            // height: 200,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2)));
  }

  Widget buildImage(String sliders, int index) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 1),
    color: Colors.grey,
    child: Image.asset(
      sliders,
      fit: BoxFit.fill,
      width: double.infinity,
    ),
  );
}


