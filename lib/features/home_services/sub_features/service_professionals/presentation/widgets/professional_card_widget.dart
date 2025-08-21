import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yelpax/shared/widgets/custom_button.dart';
import '../../../../../../core/utils/get_rating_label.dart';
import '../../../../../../shared/widgets/star_rating_widget.dart';

class ProfessionalCardWidget extends StatelessWidget {
  Map professional;
  GestureTapCallback onTap;
  ProfessionalCardWidget({
    super.key,
    required this.professional,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(professional),
              const SizedBox(width: 12),
              Expanded(
                child: _buildProfessionalDetails(
                  professional,
                  textTheme,
                  onTap,
                ),
              ),
            ],
          ),
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

Widget _buildProfessionalDetails(
  dynamic professional,
  TextTheme textTheme,
  GestureTapCallback onTap,
) {
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
      _buildLastReview(professional, textTheme, onTap),
      const SizedBox(height: 8),
      _buildDetailsOrQuotation(),
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
            IsActiveUser(isOnline: true),
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
          style: textTheme.bodyMedium,
        );
}

Widget _buildHiredCount(dynamic professional, TextTheme textTheme) {
  return Text(
    '${professional['timesHired']} Hired in yelpax',
    style: textTheme.bodySmall,
  );
}

Widget _buildPriceInfo(dynamic professional, TextTheme textTheme) {
  return Text(professional['estimatedPrice'], style: textTheme.titleSmall);
}

Widget _buildLastReview(
  dynamic professional,
  TextTheme textTheme,
  GestureTapCallback onTap,
) {
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
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
      ],
    ),
  );
}

Widget _buildDetailsOrQuotation() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomButton(
        onPressed: () => print('Details'),
        text: 'Details',
        icon: Icons.info_outline,
      ),

      CustomButton(
        text: 'Quotation',
        onPressed: () => print('Quotation'),
        icon: Icons.request_quote_outlined,
      ),
    ],
  );
}

class IsActiveUser extends StatefulWidget {
  final bool isOnline;

  const IsActiveUser({super.key, required this.isOnline});

  @override
  State<IsActiveUser> createState() => _IsActiveUserState();
}

class _IsActiveUserState extends State<IsActiveUser>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation controller for pulsing effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isOnline) {
      // Show static offline dot
      return Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      );
    }

    // Show animated pulsing online dot
    return ScaleTransition(
      scale: _animation,
      child: Container(
        width: 14,
        height: 14,
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
