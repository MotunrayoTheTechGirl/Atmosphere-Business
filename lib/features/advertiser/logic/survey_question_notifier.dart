import 'package:dealer_portal_mobile/features/advertiser/logic/survey_question.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SurveyQuestionNotifier extends StateNotifier<List<SurveyQuestion>> {
  SurveyQuestionNotifier() : super([]);

  void addQuestion(SurveyQuestion question) {
    state = [...state, question];
  }
}

final questionNotifierProvider =
    StateNotifierProvider<SurveyQuestionNotifier, List<SurveyQuestion>>(
        (ref) => SurveyQuestionNotifier());
