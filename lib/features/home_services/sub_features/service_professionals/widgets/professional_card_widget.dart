import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:yelpax/core/constants/asset_constants.dart';
import 'package:yelpax/core/utils/url_helper.dart';
import 'package:yelpax/features/home_services/data/models/home_service_promotion_model.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_fetch_professionals_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_professional_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_promotion_entity.dart';
import '../../../../../shared/widgets/custom_button.dart';
import '../../../../../shared/widgets/styled_asterisk_name.dart';
import '../../../../../core/utils/get_rating_label.dart';
import '../../../../../shared/widgets/star_rating_widget.dart';

class ProfessionalCardWidget extends StatelessWidget {
  HomeServicesFetchProfessionalsEntity professional;
  GestureTapCallback onTap;
  VoidCallback onOpenQuotation;
  ProfessionalCardWidget({
    super.key,
    required this.professional,
    required this.onTap,
    required this.onOpenQuotation,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2.2,
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
                  onOpenQuotation
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildAvatar(HomeServicesFetchProfessionalsEntity professional) {
  return CircleAvatar(
    radius: 30,
    backgroundColor: Colors.grey,
    child: ClipOval(
      child: CachedNetworkImage(

      imageUrl: UrlHelper.fixImageUrl(professional.professional.profileImage),//url helper will be changed later 
        fit: BoxFit.cover,
        width: 60,
        height: 60,
      ),
    ),
  );
}

Widget _buildProfessionalDetails(
  HomeServicesFetchProfessionalsEntity professional,
  TextTheme textTheme,
  GestureTapCallback onTap,
  VoidCallback onOpenQuotation
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildNameAndRating(professional.professional, textTheme),
      const SizedBox(height: 8),
  //    _buildAvailabilityInfo(professional, textTheme),
      // const SizedBox(height: 8),
       _buildHiredCount(professional.professional, textTheme),
      const SizedBox(height: 8),
      _buildPriceInfo(professional, textTheme),
      const SizedBox(height: 8),
      _buildLastReview(professional.professional, textTheme, onTap),
      const SizedBox(height: 8),
 _buildDetailsOrQuotation(onOpenQuotation),
    ],
  );
}

Widget _buildNameAndRating(HomeServicesProfessionalEntity professional, TextTheme textTheme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        text: TextSpan(
          children: StyledAsteriskName(
            professional.businessName,
            textTheme.titleSmall,
          ),
        ),
      ),

      const SizedBox(height: 4),
      Row(
        children: [
          Text(
            getRatingLabel(4.2),
            style: textTheme.bodySmall,
          ),
          const Spacer(),
          Text(professional.ratingAverage.toString(), style: textTheme.bodySmall),
          const SizedBox(width: 4),
           StarRatingWidget(initialRating: professional.ratingAverage.toDouble(), size: 20),
          const SizedBox(width: 4),
          Text(
            professional.totalReview.toString(),
            style: textTheme.bodySmall,
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
              style: textTheme.bodySmall?.copyWith(
                color: CupertinoColors.activeGreen,
              ),
            ),
          ],
        )
      : Text(
          'Response in ${professional['response']} min',
          style: textTheme.bodySmall,
        );
}

Widget _buildHiredCount(HomeServicesProfessionalEntity professional, TextTheme textTheme) {
  return Text(
    '${professional.totalHire} Times Hired in yelpax',
    style: textTheme.bodySmall,
  );
}

Widget _buildPriceInfo(HomeServicesFetchProfessionalsEntity professional, TextTheme textTheme) {
  return Text(
    "${professional.minimumPrice}\$ Minimum Price",
    style: textTheme.titleSmall?.copyWith(color: Colors.grey,fontSize: 14),
  );
}

Widget _buildLastReview(
  HomeServicesProfessionalEntity professional,
  TextTheme textTheme,
  GestureTapCallback onTap,
) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: professional.introduction,
          style: textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        TextSpan(
          text: ' See More',
          style: TextStyle(color: Colors.blueAccent),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
      ],
    ),
  );
}

Widget _buildDetailsOrQuotation(VoidCallback onOpenQuotation) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomButton(
        onPressed: () => print('Details'),
        text: 'Details',
        icon: Icons.info_outline,
        size: CustomButtonSize.small,
      ),

      CustomButton(
        text: 'Quotation',
        onPressed: onOpenQuotation,
        icon: Icons.request_quote_outlined,
        size: CustomButtonSize.small,
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
