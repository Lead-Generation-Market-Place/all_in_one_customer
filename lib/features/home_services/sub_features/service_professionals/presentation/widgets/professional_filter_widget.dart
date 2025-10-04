import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yelpax/core/constants/height.dart';
import 'package:yelpax/features/home_services/sub_features/service_professionals/presentation/controllers/service_professionals_controller.dart';

import '../../../../../../shared/widgets/custom_button.dart';

class ProfessionalFilterWidget extends StatefulWidget {
  TextTheme textTheme;
  ServiceProfessionalsController controller;

  ProfessionalFilterWidget({required this.textTheme, required this.controller});

  @override
  State<ProfessionalFilterWidget> createState() =>
      _ProfessionalFilterWidgetState();
}

class _ProfessionalFilterWidgetState extends State<ProfessionalFilterWidget> {
  // bool isVerified = false; // ✅ fixed
  String selectedChip = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height(context)/18,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      
      child: ListView(
       
        scrollDirection: Axis.horizontal,
        children: [
          Wrap(
            spacing: 10,
            children: [
              ChoiceChip(
                label: Text('Companies'),
                selected: selectedChip == 'companies',
                onSelected: (value) {
                  setState(() {
                    selectedChip = 'companies';
                  });
                },
              ),
              ChoiceChip(
                label: Text(widget.controller.serviceDetails['name']),
                selected:
                    selectedChip == widget.controller.serviceDetails['name'],
                onSelected: (value) {
                  setState(() {
                    selectedChip = widget.controller.serviceDetails['name'];
                  });
                },
              ),
              ChoiceChip(
                label: Text('All Professionals'),
                selected: selectedChip == 'allProfessionals',
                onSelected: (value) {
                  setState(() {
                    selectedChip = 'allProfessionals';
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

}
