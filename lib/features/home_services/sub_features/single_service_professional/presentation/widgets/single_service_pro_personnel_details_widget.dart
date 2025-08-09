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
      child: _PersonnelInfoSection(
        proCompleteDetails: proCompleteDetails,
        proDetails: proDetails,
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
          TextSpan(text: widget.text, style: widget.textTheme.bodyMedium),
          TextSpan(
            text: isExpanded ? ' See Less' : ' See More',
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () => setState(() => isExpanded = !isExpanded),
          ),
        ],
      ),
      maxLines: isExpanded ? null : 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
