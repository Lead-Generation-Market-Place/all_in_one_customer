import 'package:flutter/material.dart';
import '../../../../../../shared/widgets/custom_button.dart';

class ProfessionalFilterWidget extends StatelessWidget {
  String selectedService;
  ProfessionalFilterWidget({required this.selectedService});
  // bool isVerified = false; // ✅ fixed
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          bool allProfessionals = false;
          bool companies = false;
          bool title=false;
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
                      title: const Text("All Professionals"),
                      value: allProfessionals,
                      onChanged: (value) {
                        setState(() {
                          allProfessionals = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text("Companies"),
                      value: companies,
                      onChanged: (value) {
                        setState(() {
                          companies = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(selectedService),
                      value: title,
                      onChanged: (value) {
                        setState(() {
                          title = value ?? false;
                        });
                      },
                    ),
                    // RangeSlider(
                    //   values: selectedRange,
                    //   min: 0,
                    //   max: 50,
                    //   divisions: 50,
                    //   labels: RangeLabels(
                    //     '${selectedRange.start.round()} km',
                    //     '${selectedRange.end.round()} km',
                    //   ),
                    //   onChanged: (values) {
                    //     setState(() {
                    //       selectedRange = values;
                    //     });
                    //   },
                    // ),
                    SizedBox(height: 10),
                    CustomButton(
                      text: 'Apply',
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(height: 10),
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
