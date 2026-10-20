import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/instructor/common/data/model/quiz_model/course_quiz_create_model.dart';
import 'package:lms_admin_instructor/features/instructor/manage_quiz_instructor/presentation/bloc/cubit/manage_quiz_questions_cubit.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';
import 'choice_item_widget.dart';

class QuestionItemWidget extends StatefulWidget {
  final int index;
  final QuestionCreateModel question;
  final VoidCallback onRemove;
  final Function(QuestionCreateModel) onUpdate;

  const QuestionItemWidget({
    super.key,
    required this.index,
    required this.question,
    required this.onRemove,
    required this.onUpdate,
  });

  @override
  State<QuestionItemWidget> createState() => _QuestionItemWidgetState();
}

class _QuestionItemWidgetState extends State<QuestionItemWidget> {
  late TextEditingController _nameController;
  late TextEditingController _markController;
  late FocusNode _nameFocusNode;
  late FocusNode _markFocusNode;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.question.questionName);
    _markController = TextEditingController(text: widget.question.mark?.toString() ?? '1');
    _nameFocusNode = FocusNode();
    _markFocusNode = FocusNode();
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus && _nameController.text != widget.question.questionName) {
        _updateQuestion();
      }
    });
    _markFocusNode.addListener(() {
      if (!_markFocusNode.hasFocus && _markController.text != widget.question.mark?.toString()) {
        _updateQuestion();
      }
    });
  }

  @override
  void didUpdateWidget(QuestionItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question.questionName != widget.question.questionName &&
        _nameController.text != widget.question.questionName) {
      _nameController.text = widget.question.questionName ?? '';
    }
    if (oldWidget.question.mark != widget.question.mark &&
        _markController.text != widget.question.mark?.toString()) {
      _markController.text = widget.question.mark?.toString() ?? '1';
    }
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _markFocusNode.dispose();
    _nameController.dispose();
    _markController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 24.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: context.colorScheme.outline.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14.r,
                  backgroundColor: context.colorScheme.primary,
                  child: Text(
                    '${widget.index + 1}',
                    style: TextStyle(color: context.colorScheme.onPrimary, fontSize: 12.sp),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    context.tr('question_details'),
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: widget.onRemove,
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              txt: context.tr('question_name'),
              hint: context.tr('question_name'),
              controller: _nameController,
              focusNode: _nameFocusNode,
              validator: (value) =>
                  value == null || value.isEmpty ? context.tr('required') : null,
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    txt: context.tr('mark'),
                    hint: context.tr('mark'),
                    controller: _markController,
                    focusNode: _markFocusNode,
                    validator: (value) =>
                        value == null || value.isEmpty ? context.tr('required') : null,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: widget.question.questionType,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(value: 'single', child: Text(context.tr('single_choice'))),
                      DropdownMenuItem(value: 'multiple', child: Text(context.tr('multiple_choice'))),
                    ],
                    onChanged: (val) {
                      final updatedChoices = List<ChoiceCreateModel>.from(widget.question.choices ?? []);
                      if (val == 'single') {
                        bool foundCorrect = false;
                        for (int i = 0; i < updatedChoices.length; i++) {
                          if (updatedChoices[i].isCorrect == true && !foundCorrect) {
                            foundCorrect = true;
                          } else {
                            updatedChoices[i] = ChoiceCreateModel(
                              choiceName: updatedChoices[i].choiceName,
                              isCorrect: false,
                            );
                          }
                        }
                        if (!foundCorrect && updatedChoices.isNotEmpty) {
                          updatedChoices[0] = ChoiceCreateModel(
                            choiceName: updatedChoices[0].choiceName,
                            isCorrect: true,
                          );
                        }
                      }
                      _updateQuestion(type: val, choices: updatedChoices);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.tr('choices'),
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    _updateQuestion(
                      choices: [...(widget.question.choices ?? []), ChoiceCreateModel(choiceName: '', isCorrect: false)]
                    );
                  },
                  icon: const Icon(Icons.add, size: 16),
                  label: Text(context.tr('add_choice'), style: TextStyle(fontSize: 12.sp)),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            _ChoicesList(
              questionIndex: widget.index,
              questionType: widget.question.questionType,
              onUpdate: (updatedChoices) => _updateQuestion(choices: updatedChoices),
            ),
          ],
        ),
      ),
    );
  }

  void _updateQuestion({String? type, List<ChoiceCreateModel>? choices}) {
    widget.onUpdate(QuestionCreateModel(
      questionName: _nameController.text,
      mark: int.tryParse(_markController.text) ?? 1,
      questionType: type ?? widget.question.questionType,
      choices: choices ?? widget.question.choices,
    ));
  }
}

class _ChoicesList extends StatelessWidget {
  final int questionIndex;
  final String? questionType;
  final Function(List<ChoiceCreateModel>) onUpdate;

  const _ChoicesList({
    required this.questionIndex,
    required this.questionType,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ManageQuizQuestionsCubit,
      List<QuestionCreateModel>,
      List<ChoiceCreateModel>?>(
      selector: (state) {
        if (questionIndex >= state.length) return null;
        return state[questionIndex].choices;
      },
      builder: (context, choices) {
        final currentChoices = choices ?? [];
        return Column(
          children: currentChoices.asMap().entries.map((entry) {
            final choiceIndex = entry.key;
            return _ChoiceEntry(
              key: ValueKey('choice_${questionIndex}_$choiceIndex'),
              questionIndex: questionIndex,
              choiceIndex: choiceIndex,
              questionType: questionType,
              onUpdate: onUpdate,
            );
          }).toList(),
        );
      },
    );
  }
}

class _ChoiceEntry extends StatelessWidget {
  final int questionIndex;
  final int choiceIndex;
  final String? questionType;
  final Function(List<ChoiceCreateModel>) onUpdate;

  const _ChoiceEntry({
    super.key,
    required this.questionIndex,
    required this.choiceIndex,
    required this.questionType,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ManageQuizQuestionsCubit,
      List<QuestionCreateModel>,
      ChoiceCreateModel?>(
      selector: (state) {
        if (questionIndex >= state.length) return null;
        final choices = state[questionIndex].choices;
        if (choiceIndex >= (choices?.length ?? 0)) return null;
        return choices?[choiceIndex];
      },
      builder: (context, choice) {
        if (choice == null) return const SizedBox.shrink();
        final currentChoices = context.read<ManageQuizQuestionsCubit>().state[questionIndex].choices ?? [];

        return ChoiceItemWidget(
          key: ValueKey('choice_${questionIndex}_$choiceIndex'),
          index: choiceIndex,
          choice: choice,
          onRemove: () {
            if (currentChoices.length > 2) {
              final updated = List<ChoiceCreateModel>.from(currentChoices)
                ..removeAt(choiceIndex);
              onUpdate(updated);
            }
          },
          onUpdate: (updatedChoice) {
            final updated = List<ChoiceCreateModel>.from(currentChoices);
            if (questionType == 'single') {
              if (updatedChoice.isCorrect == true) {
                for (var i = 0; i < updated.length; i++) {
                  updated[i] = ChoiceCreateModel(
                    choiceName: i == choiceIndex ? updatedChoice.choiceName : (updated[i].choiceName ?? ''),
                    isCorrect: i == choiceIndex,
                  );
                }
              } else {
                if (currentChoices[choiceIndex].isCorrect == true) return;
                updated[choiceIndex] = updatedChoice;
              }
            } else {
              updated[choiceIndex] = updatedChoice;
            }
            onUpdate(updated);
          },
        );
      },
    );
  }
}
