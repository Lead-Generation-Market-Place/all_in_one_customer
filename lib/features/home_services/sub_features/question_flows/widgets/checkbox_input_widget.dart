import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:yelpax/core/constants/height.dart';
import 'package:yelpax/core/constants/width.dart';

/// Checkbox input for a single boolean value (checked/unchecked)
@immutable
class CheckBoxInputWidget extends StatefulWidget {
  final bool initialValue;
  final List options;
  final ValueChanged<bool> onChanged;

  CheckBoxInputWidget({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.options,
  });

  @override
  State<CheckBoxInputWidget> createState() => _CheckBoxInputWidgetState();
}

class _CheckBoxInputWidgetState extends State<CheckBoxInputWidget> {
  List<bool> checkBoxState = [];
  @override
  void initState() {
    widget.options.forEach((element) => checkBoxState.add(false));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: width(context),
        height: height(context) / 2,
        child: ListView.builder(
          itemCount: widget.options.length,
          itemBuilder: (context, index) => Card(
            child: CheckboxListTile(
              title: Text(widget.options[index]),
              value: checkBoxState[index],
              onChanged: (value) => setState(() {
                widget.onChanged(value ?? false);
                checkBoxState[index] = value ?? false;
              }),
            ),
          ),
        ),
      ),
    );
  }
}

