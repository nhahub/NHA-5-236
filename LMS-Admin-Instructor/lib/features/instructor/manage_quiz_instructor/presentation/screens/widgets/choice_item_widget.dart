import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/instructor/common/data/model/quiz_model/course_quiz_create_model.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';

class ChoiceItemWidget extends StatefulWidget {
  final int index;
  final ChoiceCreateModel choice;
  final VoidCallback onRemove;
  final Function(ChoiceCreateModel) onUpdate;

  const ChoiceItemWidget({
    super.key,
    required this.index,
    required this.choice,
    required this.onRemove,
    required this.onUpdate,
  });

  @override
  State<ChoiceItemWidget> createState() => _ChoiceItemWidgetState();
}

class _ChoiceItemWidgetState extends State<ChoiceItemWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.choice.choiceName);
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      if (_controller.text != widget.choice.choiceName) {
        widget.onUpdate(ChoiceCreateModel(
          choiceName: _controller.text,
          isCorrect: widget.choice.isCorrect,
        ));
      }
    }
  }

  @override
  void didUpdateWidget(ChoiceItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.choice.choiceName != widget.choice.choiceName &&
        _controller.text != widget.choice.choiceName) {
      _controller.text = widget.choice.choiceName ?? '';
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
            Checkbox(
              value: widget.choice.isCorrect ?? false,
              onChanged: (val) {
                widget.onUpdate(ChoiceCreateModel(
                  choiceName: _controller.text,
                  isCorrect: val,
                ));
              },
            ),
            Expanded(
              child: CustomTextFormField(
                txt: '${context.tr('choice')} ${widget.index + 1}',
                hint: '${context.tr('choice')} ${widget.index + 1}',
                controller: _controller,
                focusNode: _focusNode,
                validator: (value) =>
                    value == null || value.isEmpty ? context.tr('required') : null,
              ),
            ),
          IconButton(
            onPressed: widget.onRemove,
            icon: const Icon(Icons.close, size: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
