import 'package:flutter/material.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/domain/entities/question_flow_entity.dart';
import 'package:yelpax/shared/widgets/custom_button.dart';

class QuestionFlowWidget extends StatefulWidget {
  List<QuestionFlowEntity> questions;
  QuestionFlowWidget(this.questions);

  @override
  State<QuestionFlowWidget> createState() => _QuestionFlowWidgetState();
}

class _QuestionFlowWidgetState extends State<QuestionFlowWidget> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    print(widget.questions[0].questions.length);
    return PageView.builder(
      itemCount: widget.questions[0].questions.length,
      controller: _pageController,
      itemBuilder: (context, index) {
        TextTheme textTheme = Theme.of(context).textTheme;
        List<Question> questions = widget.questions[0].questions;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    _buildQuestion(questions[index].text, textTheme),
                    _buildQuestionOptions(
                      questions[index].type,
                      questions[index].options,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text('Back'),
                    onPressed: () {
                      setState(() {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                  ),
                  TextButton(
                    child: Text('Next'),
                    onPressed: () {
                      setState(() {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.ease,
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuestion(String title, TextTheme textTheme) {
    return Text(title, style: textTheme.titleSmall);
  }

  Widget _buildQuestionOptions(Enum questionType, List<Option> choices) {
    print(questionType);
    if (questionType == QuestionType.multipleChoice) {
      return _multipleChoiceWidget(
        choices: choices,
        onSelectionChanged: (value) => print(value),
      );

    } else if (questionType == QuestionType.number) {
      return _numberInputWidget(onChanged: (value) => print(value));
    
    } else if (questionType == QuestionType.text) {
      return _textInputWidget(onChanged: (value) => print(value),);

    } else {
      return Text('Type Not Found');
    
    }
  }
}

class _multipleChoiceWidget extends StatefulWidget {
  final List<Option> choices;
  final ValueChanged<List<Option>> onSelectionChanged;

  const _multipleChoiceWidget({
    super.key,
    required this.choices,
    required this.onSelectionChanged,
  });

  @override
  State<_multipleChoiceWidget> createState() => __multipleChoiceWidgetState();
}

class __multipleChoiceWidgetState extends State<_multipleChoiceWidget> {
  final Set<String> _selectedIds = {};

  void _onChanged(bool? selected, Option option) {
    setState(() {
      if (selected == true) {
        _selectedIds.add(option.id);
      } else {
        _selectedIds.remove(option.id);
      }
    });

    widget.onSelectionChanged(
      widget.choices.where((o) => _selectedIds.contains(o.id)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: widget.choices.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final option = widget.choices[index];
          final isSelected = _selectedIds.contains(option.id);

          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: CheckboxListTile.adaptive(
              value: isSelected,
              onChanged: (val) => _onChanged(val, option),
              title: Text(
                option.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black87,
                ),
              ),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Theme.of(context).colorScheme.primary,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          );
        },
      ),
    );
  }
}

class _numberInputWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? initialValue;

  const _numberInputWidget({
    super.key,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<_numberInputWidget> createState() => __numberInputWidgetState();
}

class __numberInputWidgetState extends State<_numberInputWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Enter number",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}


class _textInputWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? initialValue;

  const _textInputWidget({
    super.key,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<_textInputWidget> createState() => __textInputWidgetState();
}

class __textInputWidgetState extends State<_textInputWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.text,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: "Your answer",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}

class _singleChoiceWidget extends StatefulWidget {
  final List<Option> choices;
  final ValueChanged<Option> onSelectionChanged;
  final String? initialSelectedId;

  const _singleChoiceWidget({
    super.key,
    required this.choices,
    required this.onSelectionChanged,
    this.initialSelectedId,
  });

  @override
  State<_singleChoiceWidget> createState() => __singleChoiceWidgetState();
}

class __singleChoiceWidgetState extends State<_singleChoiceWidget> {
  String? _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialSelectedId;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: widget.choices.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final option = widget.choices[index];
        final isSelected = option.id == _selectedId;

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: RadioListTile<String>(
            value: option.id,
            groupValue: _selectedId,
            onChanged: (val) {
              setState(() {
                _selectedId = val;
              });
              widget.onSelectionChanged(option);
            },
            title: Text(
              option.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black87,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.primary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        );
      },
    );
  }
}
