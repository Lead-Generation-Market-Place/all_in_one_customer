import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/get_rating_label.dart';
import '../../../../../../shared/widgets/star_rating_widget.dart';

class ProfessionalCardWidget extends StatelessWidget {
  Map professional;
  ProfessionalCardWidget({super.key, required this.professional});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatar(professional),
            const SizedBox(width: 12),
            Expanded(child: _buildProfessionalDetails(professional, textTheme)),
          ],
        ),
      ),
    );
  }
}

Widget _buildAvatar(dynamic professional) {
  return CircleAvatar(
    radius: 30,
    backgroundColor: Colors.grey,
    child: ClipOval(
      child: Image.asset(
        'assets/images/splash_1.jpg',
        fit: BoxFit.cover,
        width: 60,
        height: 60,
      ),
    ),
  );
}

Widget _buildProfessionalDetails(dynamic professional, TextTheme textTheme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildNameAndRating(professional, textTheme),
      const SizedBox(height: 8),
      _buildAvailabilityInfo(professional, textTheme),
      const SizedBox(height: 8),
      _buildHiredCount(professional, textTheme),
      const SizedBox(height: 8),
      _buildPriceInfo(professional, textTheme),
      const SizedBox(height: 8),
      _buildLastReview(professional, textTheme),
    ],
  );
}

Widget _buildNameAndRating(dynamic professional, TextTheme textTheme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        professional['name'],
        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 4),
      Row(
        children: [
          Text(
            getRatingLabel(professional['ratings']),
            style: textTheme.bodyMedium,
          ),
          const Spacer(),
          Text(professional['ratings'].toString(), style: textTheme.bodyMedium),
          const SizedBox(width: 4),
          StarRatingWidget(initialRating: professional['ratings'], size: 20),
          const SizedBox(width: 4),
          Text(
            '(${professional['starsCount'] ?? 0})',
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    ],
  );
}

Widget _buildAvailabilityInfo(dynamic professional, TextTheme textTheme) {
  return professional['isActive']
      ? Row(
          children: [
            CircleAvatar(radius: 8, backgroundColor: Colors.green),
            const SizedBox(width: 4),
            Text(
              'Online Now',
              style: textTheme.bodyMedium?.copyWith(
                color: CupertinoColors.activeGreen,
              ),
            ),
          ],
        )
      : Text(
          'Response in ${professional['response']} min',
          style: textTheme.bodyMedium?.copyWith(
            color: CupertinoColors.systemGrey,
          ),
        );
}

Widget _buildHiredCount(dynamic professional, TextTheme textTheme) {
  return Text(
    '${professional['timesHired']} Hired in yelpax',
    style: textTheme.bodySmall,
  );
}

Widget _buildPriceInfo(dynamic professional, TextTheme textTheme) {
  return Text(
    professional['estimatedPrice'],
    style: textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: CupertinoColors.systemGreen,
    ),
  );
}

Widget _buildLastReview(dynamic professional, TextTheme textTheme) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: professional['lastReviewText'] ?? '',
          style: textTheme.bodySmall,
        ),
        TextSpan(
          text: ' See More',
          style: TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()..onTap = () {},
        ),
      ],
    ),
  );
}
