import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/instructor/manage_quiz_instructor/presentation/bloc/cubit/manage_quiz_questions_cubit.dart';
import 'package:lms_admin_instructor/features/instructor/manage_quiz_instructor/presentation/bloc/manage_quiz_instructor_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/manage_quiz_instructor/presentation/bloc/manage_quiz_instructor_event.dart';
import 'package:lms_admin_instructor/features/instructor/manage_quiz_instructor/presentation/bloc/manage_quiz_instructor_state.dart';
import 'package:lms_admin_instructor/features/instructor/common/data/model/quiz_model/course_quiz_create_model.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';
import 'package:lms_admin_instructor/features/widgets/loading_indicator_widget.dart';
import 'widgets/question_item_widget.dart';

class ManageQuizScreen extends StatefulWidget {
  final String courseSlug;
  final String? quizSlug;
  const ManageQuizScreen({super.key, required this.courseSlug, this.quizSlug});

  @override
  State<ManageQuizScreen> createState() => _ManageQuizScreenState();
}

class _ManageQuizScreenState extends State<ManageQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quizNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _maxAttemptsController = TextEditingController(text: '5');
  final _passingPercentageController = TextEditingController(text: '50');
  late final ManageQuizQuestionsCubit _questionsCubit;

  @override
  void initState() {
    super.initState();
    _questionsCubit = ManageQuizQuestionsCubit();
    if (widget.quizSlug != null) {
      context.read<ManageQuizInstructorBloc>().add(
        GetQuizDetailsEvent(quizSlug: widget.quizSlug!),
      );
    } else {
      _questionsCubit.init([]);
    }
  }

  @override
  void dispose() {
    _quizNameController.dispose();
    _descriptionController.dispose();
    _maxAttemptsController.dispose();
    _passingPercentageController.dispose();
    _questionsCubit.close();
    super.dispose();
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      final quizData = CourseQuizCreateModel(
        quizName: _quizNameController.text,
        description: _descriptionController.text,
        maxAttempts: int.tryParse(_maxAttemptsController.text),
        passingPercentage: int.tryParse(_passingPercentageController.text),
        questions: _questionsCubit.questions,
        slug: widget.courseSlug,
      );

      if (widget.quizSlug != null) {
        context.read<ManageQuizInstructorBloc>().add(
          UpdateQuizEvent(
            courseSlug: widget.courseSlug,
            quizSlug: widget.quizSlug!,
            quizData: quizData,
          ),
        );
      } else {
        context.read<ManageQuizInstructorBloc>().add(
          CreateQuizEvent(courseSlug: widget.courseSlug, quizData: quizData),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.quizSlug != null
              ? context.tr('edit_quiz')
              : context.tr('add_quiz'),
        ),
      ),
      body: BlocConsumer<ManageQuizInstructorBloc, ManageQuizInstructorState>(
        listener: (context, state) {
          if (state is ManageQuizInstructorSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  widget.quizSlug != null
                      ? context.tr('quiz_updated_success')
                      : context.tr('quiz_created_success'),
                ),
              ),
            );
            context.pop(true);
          } else if (state is ManageQuizInstructorError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is GetQuizDetailsSuccess) {
            _quizNameController.text = state.quiz.quizName ?? '';
            _descriptionController.text = state.quiz.description ?? '';
            _maxAttemptsController.text =
                state.quiz.maxAttempts?.toString() ?? '5';
            _passingPercentageController.text =
                state.quiz.passingPercentage?.toString() ?? '50';
            _questionsCubit.init(
              state.quiz.questions
                      ?.map(
                        (q) => QuestionCreateModel(
                          questionName: q.questionName,
                          mark: q.mark?.toInt(),
                          questionType: q.questionType,
                          choices:
                              q.choices
                                  ?.map(
                                    (c) => ChoiceCreateModel(
                                      choiceName: c.choiceName,
                                      isCorrect: c.isCorrect,
                                    ),
                                  )
                                  .toList() ??
                              [],
                        ),
                      )
                      .toList() ??
                  [],
            );
          } else if (state is GetQuizDetailsError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is ManageQuizInstructorLoading ||
              state is GetQuizDetailsLoading) {
            return const LoadingIndicatorWidget();
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: context.isDesktop ? 100.w : 16.w,
              vertical: 24.h,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('quiz_info'),
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    txt: context.tr('quiz_name'),
                    hint: context.tr('quiz_name'),
                    controller: _quizNameController,
                    validator: (value) => value == null || value.isEmpty
                        ? context.tr('required')
                        : null,
                  ),
                  SizedBox(height: 12.h),
                  CustomTextFormField(
                    txt: context.tr('description'),
                    hint: context.tr('description'),
                    controller: _descriptionController,
                    maxLines: 3,
                  ),
                  SizedBox(height: 12.h),
                  CustomTextFormField(
                    txt: context.tr('max_attempts'),
                    hint: context.tr('max_attempts'),
                    controller: _maxAttemptsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) => value == null || value.isEmpty
                        ? context.tr('required')
                        : null,
                  ),
                  SizedBox(height: 12.h),
                  CustomTextFormField(
                    txt: context.tr('passing_percentage'),
                    hint: context.tr('passing_percentage'),
                    controller: _passingPercentageController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) => value == null || value.isEmpty
                        ? context.tr('required')
                        : null,
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    context.tr('questions'),
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  BlocProvider.value(
                    value: _questionsCubit,
                    child: const _QuestionsList(),
                  ),
                  SizedBox(height: 32.h),
                  Center(
                    child: CustomPrimaryButton(
                      text: widget.quizSlug != null
                          ? context.tr('update')
                          : context.tr('submit'),
                      onTap: _submit,
                      width: context.isDesktop ? 300.w : double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _QuestionsList extends StatelessWidget {
  const _QuestionsList();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManageQuizQuestionsCubit>();
    return BlocSelector<
      ManageQuizQuestionsCubit,
      List<QuestionCreateModel>,
      int
    >(
      selector: (state) => state.length,
      builder: (context, length) {
        return Column(
          children: [
            ...List.generate(length, (index) {
              return _QuestionEntry(
                key: ValueKey('q_entry_$index'),
                index: index,
              );
            }),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton.icon(
                onPressed: cubit.addQuestion,
                icon: const Icon(Icons.add),
                label: Text(context.tr('add_question')),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _QuestionEntry extends StatelessWidget {
  final int index;
  const _QuestionEntry({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManageQuizQuestionsCubit>();
    return BlocSelector<
      ManageQuizQuestionsCubit,
      List<QuestionCreateModel>,
      QuestionCreateModel?
    >(
      selector: (state) => index < state.length ? state[index] : null,
      builder: (context, question) {
        if (question == null) return const SizedBox.shrink();
        return QuestionItemWidget(
          key: ValueKey('question_$index'),
          index: index,
          question: question,
          onRemove: () => cubit.removeQuestion(index),
          onUpdate: (updated) => cubit.updateQuestion(index, updated),
        );
      },
    );
  }
}
