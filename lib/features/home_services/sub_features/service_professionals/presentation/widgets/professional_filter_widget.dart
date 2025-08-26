import 'package:flutter/material.dart';
import 'package:yelpax/shared/widgets/custom_button.dart';

class ProfessionalFilterWidget extends StatefulWidget {
  @override
  State<ProfessionalFilterWidget> createState() =>
      _ProfessionalFilterWidgetState();
}

class _ProfessionalFilterWidgetState extends State<ProfessionalFilterWidget> {
  // bool isVerified = false; // ✅ fixed
  // bool isAvailable = false; // ✅ fixed

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          bool isVerified = false;
          bool isAvailable = false;
                  RangeValues selectedRange = RangeValues(5, 20);
           return StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Filter Professionals",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      title: const Text("Verified Only"),
                      value: isVerified,
                      onChanged: (value) {
                        setState(() {
                          isVerified = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text("Available Now"),
                      value: isAvailable,
                      onChanged: (value) {
                        setState(() {
                          isAvailable = value ?? false;
                        });
                      },
                    ),

RangeSlider(
  values: selectedRange,
  min: 0,
  max: 50,
  divisions: 50,
  labels: RangeLabels(
    '${selectedRange.start.round()} km',
    '${selectedRange.end.round()} km',
  ),
  onChanged: (values) {
    setState(() {
      selectedRange = values;
    });
  },
),
                    CustomButton(
                      text: 'Apply',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      icon: Icon(Icons.tune),
    );
  }
}
