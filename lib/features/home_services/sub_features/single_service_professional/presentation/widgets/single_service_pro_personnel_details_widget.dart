import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yelpax/core/constants/height.dart';
import 'package:yelpax/core/utils/get_rating_label.dart';
import 'package:yelpax/shared/widgets/custom_button.dart';

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
        ],
      ),
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
            title: Text(
              proDetails['name'],
              style: Theme.of(context).textTheme.titleLarge,
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
