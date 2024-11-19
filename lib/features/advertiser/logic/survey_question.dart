class SurveyQuestion {
  final String question;
  final List<String> responses;
  final bool isPollQuestionType;
  final bool isShortQuestionType;
  final bool isYesOrNoQuestionType;

  SurveyQuestion({
    required this.question,
    required this.responses,
    // required this.questionType,
    required this.isPollQuestionType,
    required this.isShortQuestionType,
    required this.isYesOrNoQuestionType,
  });
}
