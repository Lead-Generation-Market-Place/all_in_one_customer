import 'package:flutter/material.dart';
import 'package:yelpax/core/utils/get_rating_label.dart';

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
      ],
    ),
  );
}
