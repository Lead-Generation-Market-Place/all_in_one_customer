import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yelpax/core/constants/height.dart';
import 'package:yelpax/core/utils/get_rating_label.dart';
import 'package:yelpax/shared/widgets/custom_button.dart';

class SingleServiceProPersonnelDetailsWidget extends StatelessWidget {
  Map proDetails;
  Map proCompleteDetails;
  SingleServiceProPersonnelDetailsWidget({
    super.key,
    required this.proCompleteDetails,
    required this.proDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildPersonnelInfo(proCompleteDetails, proDetails, context),
        ],
      ),
    );
  }
}

Widget _buildPersonnelInfo(
  Map proCompleteDetails,
  Map proDetails,
  BuildContext context,
) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(proCompleteDetails['imageUrl']),
            ),

            Expanded(
              child: ListTile(
                title: Text(proDetails['name'], style: textTheme.titleLarge),
                subtitle: Text(
                  'Typically responds in about ${proDetails['response']}',
                  style: textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text('Top Pro'),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(getRatingLabel(proCompleteDetails['ratings'])),
                  SizedBox(width: 10),
                  Text(proCompleteDetails['ratings'].toString()),
                  SizedBox(width: 10),

                  Text('(${proCompleteDetails['starsCount']})'),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Text(
          '${proCompleteDetails['estimatedPrice']}/hour',
          style: textTheme.titleSmall,
        ),
        Text(
          '${proCompleteDetails['response']} minutes minimum',
          style: textTheme.bodySmall,
        ),
        TextButton(
          onPressed: () {
            print('Tapped View price details');
          },
          child: Text(
            'View price details',
            style: textTheme.titleSmall!.copyWith(color: Colors.blue),
          ),
        ),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Your Project'),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
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
                    Icon(Icons.message_outlined),
                    Text('Responds in about ${proCompleteDetails['response']}'),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text('About this pro', style: textTheme.titleSmall),
        _buildExpandableText(
          text: proCompleteDetails['aboutPro'],
          textTheme: textTheme,
        ),
        SizedBox(height: 20),
        Text('Overview', style: textTheme.titleSmall),
        Row(children: [Icon(CupertinoIcons.tropicalstorm)]),
      ],
    ),
  );
}

class _buildExpandableText extends StatefulWidget {
  String text;
  TextTheme textTheme;
  _buildExpandableText({
    super.key,
    required this.text,
    required this.textTheme,
  });

  @override
  State<_buildExpandableText> createState() => __buildExpandableTextState();
}

class __buildExpandableTextState extends State<_buildExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Text(
              widget.text,
              maxLines: isExpanded ? 100 : 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextSpan(
            text: isExpanded ? 'See Less' : 'See More',
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () => setState(() {
                isExpanded = !isExpanded;
              }),
          ),
        ],
      ),
    );
  }
}
