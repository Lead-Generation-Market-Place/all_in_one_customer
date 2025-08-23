import 'package:flutter/material.dart';
import 'package:yelpax/shared/widgets/custom_button.dart';

class ProfessionalFilterWidget extends StatefulWidget {
  @override
  State<ProfessionalFilterWidget> createState() =>
      _ProfessionalFilterWidgetState();
}

class _ProfessionalFilterWidgetState extends State<ProfessionalFilterWidget> {
  bool? isVerified = false;

  bool? isAvailable = false;
  _showFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Filter Professionals",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 10),
              CheckboxListTile(
                title: Text("Verified Only"),
                value: isVerified,
                onChanged: (value) {
                  setState(() {
                    isVerified = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Available Now"),
                value: isAvailable,
                onChanged: (value) {
                  print(value);
                  setState(() {
                    isAvailable = value;
                  });
                },
              ),
              CustomButton(text: 'Apply', onPressed: () => print('Applied')),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showFilter(context),
      icon: Icon(Icons.tune),
    );
  }
}
