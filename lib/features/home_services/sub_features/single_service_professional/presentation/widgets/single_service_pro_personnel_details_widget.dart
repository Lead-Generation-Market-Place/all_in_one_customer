import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/constants/height.dart';
import '../../../../../../core/constants/width.dart';
import '../../../../../../core/utils/get_rating_label.dart';
import '../../../../../../shared/widgets/custom_button.dart';
import '../../../../../../shared/widgets/custom_input.dart';
import '../../../../../../shared/widgets/star_rating_widget.dart';
import '../../../../../../shared/widgets/styled_asterisk_name.dart';

class SingleServiceProPersonnelDetailsWidget extends StatelessWidget {
  final proDetails;
  final proCompleteDetails;

  const SingleServiceProPersonnelDetailsWidget({
    super.key,
    required this.proCompleteDetails,
    required this.proDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: _PersonnelInfoSection(
          proCompleteDetails: proCompleteDetails,
          proDetails: proDetails,
        ),
      ),
    );
  }
}

class _PersonnelInfoSection extends StatelessWidget {
  final Map proCompleteDetails;
  final Map proDetails;

  const _PersonnelInfoSection({
    required this.proCompleteDetails,
    required this.proDetails,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    TextEditingController _reviewController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 10),
          _buildBadgesSection(),
          const SizedBox(height: 30),
          _buildPricingSection(textTheme),
          _buildProjectCard(context),
          const SizedBox(height: 10),
          _buildAboutProSection(textTheme),
          const SizedBox(height: 20),
          _buildOverviewSection(textTheme),
          const SizedBox(height: 10),
          _buildBusinessHours(textTheme),
          const SizedBox(height: 10),
          _buildPaymentSection(textTheme),
          const SizedBox(height: 10),
          _buildTopStatus(textTheme),
          Divider(),
          _buildServiceOfferedSection(textTheme),
          Divider(),
          _buildProjectAndMedia(textTheme, proCompleteDetails),
          Divider(height: 50),
          _buildReviewSection(textTheme),
          Divider(height: 50),
          _buildReviews(textTheme, _reviewController),
        ],
      ),
    );
  }

  Widget _buildReviews(
    TextTheme textTheme,
    TextEditingController _reviewController,
  ) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Your trust means everything to us. ',
                style: textTheme.bodySmall,
              ),
              TextSpan(
                text: 'Learn about our review guidelines.',
                style: textTheme.bodySmall!.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomInput(
                hint: 'Review',
                icon: Icons.person_outline,
                controller: _reviewController,
              ),
            ),
            SizedBox(width: 10),
            DropdownButton(
              value: 'Highest rated',
              borderRadius: BorderRadius.circular(12),

              items: [
                DropdownMenuItem(
                  value: 'Highest rated',
                  child: Text('Highest rated'),
                ),
                DropdownMenuItem(
                  value: 'Lowest rated',
                  child: Text('Lowest rated'),
                ),
                DropdownMenuItem(
                  value: 'Newest first',
                  child: Text('Newest first'),
                ),
                DropdownMenuItem(
                  value: 'Older first',
                  child: Text('Older first'),
                ),
              ],
              onChanged: (value) => print(value),
            ),
          ],
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          height: 600,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return _singleReview(
                textTheme: textTheme,
                proCompleteDetails:
                    proCompleteDetails['reviewsCompleteDetails'][index],
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: 3,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSection(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reviews', style: textTheme.titleSmall),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Customers rated pro highly for ',
                style: textTheme.bodySmall,
              ),
              TextSpan(
                text: 'professionalism, work quality,',
                style: textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              TextSpan(text: ' and ', style: textTheme.bodySmall),
              TextSpan(
                text: 'responsiveness.',
                style: textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${getRatingLabel(proCompleteDetails['ratings'] ?? '')} ${proCompleteDetails['ratings'] ?? ''}',
                  style: textTheme.titleMedium!.copyWith(color: Colors.green),
                ),
                StarRatingWidget(
                  initialRating: proCompleteDetails['ratings'],
                  size: 30,
                ),
                Text('${proCompleteDetails['starsCount'] ?? ''} reviews'),
              ],
            ),
            VerticalDivider(),
            Column(
              children: [
                Container(
                  height: 100,
                  width: 200,
                  child: ListView.builder(
                    reverse: true,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return StarRatingWidget(initialRating: 2);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(proCompleteDetails['imageUrl']),
        ),
        Expanded(
          child: ListTile(
            title: RichText(
              text: TextSpan(
                children: StyledAsteriskName(
                  proDetails['name'],
                  Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),

            subtitle: Text(
              'Typically responds in about ${proDetails['response']}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBadgesSection() {
    return Row(
      children: [
        _buildBadge('Top Pro'),
        const SizedBox(width: 20),
        _buildRatingBadge(),
      ],
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text),
    );
  }

  Widget _buildRatingBadge() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(getRatingLabel(proCompleteDetails['ratings'])),
          const SizedBox(width: 10),
          Text(proCompleteDetails['ratings'].toString()),
          const SizedBox(width: 10),
          Text('(${proCompleteDetails['starsCount']})'),
        ],
      ),
    );
  }

  Widget _buildPricingSection(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${proCompleteDetails['estimatedPrice']}/hour',
          style: textTheme.titleSmall,
        ),
        Text(
          '${proCompleteDetails['response']} minutes minimum',
          style: textTheme.bodySmall,
        ),
        TextButton(
          onPressed: () => print('Tapped View price details'),
          child: Text(
            'View price details',
            style: textTheme.titleSmall!.copyWith(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectCard(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Your Project'),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Local Moving (under 50 miles) 3367'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              text: 'Message pro',
              icon: Icons.chat_outlined,
              height: height(context) / 16,
              enabled: true,
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.message_outlined),
                Text('Responds in about ${proCompleteDetails['response']}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutProSection(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About this pro', style: textTheme.titleSmall),
        ExpandableText(
          text: proCompleteDetails['aboutPro'],
          textTheme: textTheme,
        ),
      ],
    );
  }

  Widget _buildOverviewSection(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Overview', style: textTheme.titleSmall),
        _OverviewSection(proCompleteDetails: proCompleteDetails),
      ],
    );
  }

  Widget _buildBusinessHours(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Business hours', style: textTheme.titleSmall),
        _BusinessHoursSection(
          proCompleteDetails: proCompleteDetails,
          textTheme: textTheme,
        ),
      ],
    );
  }
}

Widget _buildPaymentSection(TextTheme textTheme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Payment methods', style: textTheme.titleSmall),
      Text(
        'This pro accepts payments via Apple Pay, Cash Credit card, PayPal, Stripe, Venomo and Zelle',
      ),
    ],
  );
}

Widget _buildTopStatus(TextTheme textTheme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Top Pro status', style: textTheme.titleSmall),
      Text(
        'Top Pros are among the highest rated, most popular professionals on Thumbtack',
      ),
      SizedBox(height: 20),
      Container(
        height: 200,
        width: double.infinity,
        child: ListView(
          scrollDirection: Axis.horizontal,

          children: [
            Column(
              spacing: 10,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.star_outline, size: 50),
                ),
                Text('2024'),
              ],
            ),
            SizedBox(width: 20),
            Column(
              spacing: 10,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.star_outline, size: 50),
                ),
                Text('2023'),
              ],
            ),
            SizedBox(width: 20),
            Column(
              spacing: 10,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.star_outline, size: 50),
                ),
                Text('2022'),
              ],
            ),
            SizedBox(width: 20),
            Column(
              spacing: 10,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.star_outline, size: 50),
                ),
                Text('2021'),
              ],
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            text: 'Message',
            onPressed: () => print('message'),
            icon: Icons.message_outlined,
          ),
          CustomButton(
            text: 'Request a call',
            onPressed: () => print('request call'),
            icon: Icons.call_outlined,
          ),
        ],
      ),
    ],
  );
}

Widget _buildServiceOfferedSection(TextTheme textTheme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Service Offered', style: textTheme.titleSmall),
      SizedBox(height: 10),

      SizedBox(height: 10),
      _serviceOfferedItem(
        title: 'Wall material',
        textTheme: textTheme,
        isTitle: false,
      ),
      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'Drywall',
      ),
      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'Brick, concerete, or stone',
      ),
      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'Plaster',
      ),
      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'Wood',
      ),
      _serviceOfferedItem(
        title: 'TV larger than 60 inches',
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: false,
      ),
      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'No',
      ),
      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'Yes',
      ),
      _serviceOfferedItem(
        title: 'Conceal cables/wires?',
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: false,
      ),
      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'Yes',
      ),
      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'No',
      ),
      _serviceOfferedItem(
        title: 'Type of mount',
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: false,
      ),
      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'Flat',
      ),
      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'Tilt',
      ),

      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'Swivel',
      ),

      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'Articulating',
      ),
      _serviceOfferedItem(
        title: 'Peripheral devices to connect to the TV',
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: false,
      ),
      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'Cable/satellite box',
      ),
      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'DVD/ Blue-ray player',
      ),

      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'Gaming console',
      ),
      _serviceOfferedItem(
        title: 'Sound system',
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: false,
      ),
      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.done,
        isTitle: true,
        itemKey: 'Sound bar',
      ),
      _serviceOfferedItem(
        textTheme: textTheme,
        icon: Icons.close,
        isTitle: true,
        itemKey: "Doesn't offer: Stero sound system, surround sound",
      ),
    ],
  );
}

Widget _buildProjectAndMedia(TextTheme textTheme, Map proDetails) {
  List photos = proDetails['photos'];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Project and media', style: textTheme.titleSmall),
      Text('${photos.length} photos'),
      Container(
        width: double.infinity,
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _projectAndMediaItem(proDetails: proDetails);
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: 8,
        ),
      ),
    ],
  );
}

class _singleReview extends StatelessWidget {
  Map proCompleteDetails;
  TextTheme textTheme;
  _singleReview({
    super.key,
    required this.proCompleteDetails,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(proCompleteDetails['imageUrl']),
            radius: 25,
          ),
          title: Text(proCompleteDetails['name'], style: textTheme.titleSmall),
          subtitle: StarRatingWidget(initialRating: 3),
          trailing: Column(
            children: [
              Text(
                proCompleteDetails['lastOnline'],
                style: textTheme.bodyMedium,
              ),
              Text('Hired on Yelpax', style: textTheme.bodyMedium),
            ],
          ),
        ),
        Text(proCompleteDetails['reviewText'], style: textTheme.bodySmall),
      ],
    );
  }
}

class _projectAndMediaItem extends StatefulWidget {
  Map proDetails;
  _projectAndMediaItem({super.key, required this.proDetails});

  @override
  State<_projectAndMediaItem> createState() => __projectAndMediaItemState();
}

class __projectAndMediaItemState extends State<_projectAndMediaItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context) / 4,
      width: width(context) / 1.8,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash_1.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }
}

class _serviceOfferedItem extends StatelessWidget {
  String title;
  TextTheme textTheme;
  IconData icon;
  String itemKey;
  bool isTitle;
  _serviceOfferedItem({
    super.key,
    this.title = 'sample',
    required this.textTheme,
    this.icon = Icons.abc,
    this.itemKey = 'sample',
    this.isTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isTitle
            ? SizedBox.shrink()
            : Text(title, style: textTheme.titleSmall!.copyWith(fontSize: 16)),
        isTitle
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(icon, color: Colors.green),
                  Text(itemKey, style: textTheme.bodySmall),
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }
}

class _BusinessHoursSection extends StatelessWidget {
  Map proCompleteDetails;
  TextTheme textTheme;
  _BusinessHoursSection({
    super.key,
    required this.proCompleteDetails,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Sun'), Text('8:00 am - 10:00 pm')],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Mon'), Text('8:00 am - 10:00 pm')],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Tues'), Text('8:00 am - 10:00 pm')],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Wed'), Text('8:00 am - 10:00 pm')],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Thurs'), Text('8:00 am - 10:00 pm')],
          ),
          SizedBox(height: 10),
          Text('Times in Eastern Time Zone', style: textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _OverviewSection extends StatelessWidget {
  final Map proCompleteDetails;

  const _OverviewSection({required this.proCompleteDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProInfoRow(
          icon: Icons.star_outline,
          text: 'Hired ${proCompleteDetails['timesHired']} times',
        ),
        _ProInfoRow(
          icon: Icons.location_on_outlined,
          text: proCompleteDetails['location'] ?? "",
        ),
        _ProInfoRow(
          icon: Icons.done,
          text: proCompleteDetails['backgroundStatus'] ?? "",
        ),
        _ProInfoRow(
          icon: Icons.person_add_alt_1_outlined,
          text: proCompleteDetails['employeesCount'] ?? "",
        ),
        _ProInfoRow(
          icon: Icons.history,
          text: proCompleteDetails['timeInBusiness'] ?? "",
        ),
      ],
    );
  }
}

class _ProInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ProInfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(children: [Icon(icon), const SizedBox(width: 10), Text(text)]);
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final TextTheme textTheme;

  const ExpandableText({
    super.key,
    required this.text,
    required this.textTheme,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Text(
              widget.text,
              style: widget.textTheme.bodyMedium,
              maxLines: isExpanded ? 100 : 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextSpan(
            text: isExpanded ? ' See Less' : ' See More',
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() => isExpanded = !isExpanded);
              },
          ),
        ],
      ),
    );
  }
}
