import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uol_new/model/add_banner.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:uol_new/view/homepage/banner/banner_card.dart';



class CarouselSliderView extends StatefulWidget {
  final List<AdBanner> bannerList;

  const CarouselSliderView({Key? key, required this.bannerList})
      : super(key: key);

  @override
  State<CarouselSliderView> createState() => _CarouselSliderViewState();
}

class _CarouselSliderViewState extends State<CarouselSliderView> {
  int _currentIndex = 0;
  late List<Widget> _bannerList;

  @override
  void initState() {
    _bannerList =
        widget.bannerList.map((e) =>
            BannerCard(imageUrl: e.image)).toList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: _bannerList,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16/9,
            viewportFraction: 1,
          ),
        ),
      ],
    );
  }
}
