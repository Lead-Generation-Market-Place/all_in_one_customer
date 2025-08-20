import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yelpax/core/constants/height.dart';

class PromotionBannerWidget extends StatefulWidget {
  final List<Widget> items; // promotions can be any widget (image, text, etc.)
  final Duration autoScrollDuration;
  final Duration animationDuration;

  const PromotionBannerWidget({
    super.key,
    required this.items,
    this.autoScrollDuration = const Duration(seconds: 3),
    this.animationDuration = const Duration(milliseconds: 400),
  });

  @override
  State<PromotionBannerWidget> createState() => _PromotionBannerWidgetState();
}

class _PromotionBannerWidgetState extends State<PromotionBannerWidget> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(widget.autoScrollDuration, (timer) {
      if (_currentPage < widget.items.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: widget.animationDuration,
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height(context) / 6,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.items.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.items[index],
                ),
              );
            },
          ),
          // Dot indicators
          Positioned(
            bottom: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.items.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 12 : 8,
                  height: _currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
