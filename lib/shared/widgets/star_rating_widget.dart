import 'package:flutter/material.dart';
import '../../core/constants/width.dart';

class StarRatingWidget extends StatefulWidget {
  final double maxStars;
  final double initialRating;
  final Function(double)? onRatingChanged;
  final bool isReviewing;
  final double size;

  const StarRatingWidget({
    Key? key,
    this.maxStars = 5,
    this.initialRating = 0.0,
    this.onRatingChanged,
    this.isReviewing = false,
    this.size = 20,
  }) : super(key: key);

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRatingWidget> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  void _handleTap(int index) {
    if (widget.isReviewing && widget.onRatingChanged != null) {
      setState(() {
        // +1 because index starts from 0
        _currentRating = index + 1.0;
        widget.onRatingChanged!(_currentRating);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maxStars.toInt(), (index) {
        IconData icon;
        if (index + 1 <= _currentRating.floor()) {
          icon = Icons.star;
        } else if (index + 0.5 <= _currentRating) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }

        return GestureDetector(
          onTap: () => _handleTap(index),
          behavior: HitTestBehavior.opaque,
          child: Icon(icon, color: Colors.amber, size: widget.size),
        );
      }),
    );
  }
}
