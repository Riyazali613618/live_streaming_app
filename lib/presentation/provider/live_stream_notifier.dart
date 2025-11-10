import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/live_stream_entity.dart';
import '../../domain/usecase/get_live_streams_use_case.dart';
class LiveStreamNotifier extends StateNotifier<AsyncValue<List<LiveStreamEntity>>> {
  final GetLiveStreamsUseCase _getLiveStreamsUseCase;

  LiveStreamNotifier(this._getLiveStreamsUseCase) : super(const AsyncValue.loading()) {
    fetchStreams();
  }

  Future<void> fetchStreams() async {
    try {
      state = const AsyncValue.loading();
      final streams = await _getLiveStreamsUseCase.call();
      state = AsyncValue.data(streams);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}