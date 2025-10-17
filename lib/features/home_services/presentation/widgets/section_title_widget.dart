import 'package:flutter/material.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;
 
  final bool isNavigating;
  SectionTitleWidget({required this.title,this.isNavigating=false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.left,
          ),
        ),
        isNavigating
            ? IconButton(
                onPressed: () => print(title),
                icon: Icon(Icons.arrow_forward_ios_outlined),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
