import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/screens/create_ads_screen.dart';
import '../models/metric_overview_res_model.dart';
import '../repository/metric_overview_repository.dart';

final fetchMetricOverviewControllerProvider = StateNotifierProvider<
    FetchMetricOverviewController, AsyncValue<MetricOverviewResModel>>((ref) {
  return FetchMetricOverviewController(
      ref.read(metricOverviewRepositoryProvider), ref);
});

class FetchMetricOverviewController
    extends StateNotifier<AsyncValue<MetricOverviewResModel>> {
  final MetricOverviewRepository metricOverviewRepository;
  final Ref ref;

  FetchMetricOverviewController(this.metricOverviewRepository, this.ref)
      : super(const AsyncValue.loading());

  Future<void> metricOverview({
    required String period,
  }) async {
    state = const AsyncValue.loading();
    try {
      final data = await metricOverviewRepository.metricOverview(
        advertiserId: int.parse(ref.watch(advertiserIdStateProvider)),
        period: period,
      );
      log('metric data controller: $data');
      state = AsyncValue.data(data);
    } catch (e, st) {
      log('metric controller error: $e');
      state = AsyncValue.error(e, st);
    }
  }
}
