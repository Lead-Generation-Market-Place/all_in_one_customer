import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yelpax/core/constants/height.dart';

class PromotionBannerWidget extends StatefulWidget {
  const PromotionBannerWidget({super.key});

  @override
  State<PromotionBannerWidget> createState() => _PromotionBannerWidgetState();
}

class _PromotionBannerWidgetState extends State<PromotionBannerWidget> {
  late PageController _pageController;
  late Timer _timer;

  final List<Color> _colors = [
    Colors.pink,
    Colors.amber,
    Colors.black,
    Colors.green,
  ];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentPage < _colors.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // loop back to first page
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height(context) / 6,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _colors.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _colors[index],
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            },
          ),
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _colors.length,
            itemBuilder: (context, index) {
              return _buildDots(Colors.orange);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDots(Color selected) {
    return CircleAvatar(radius: 10, backgroundColor: selected);
  }
}
