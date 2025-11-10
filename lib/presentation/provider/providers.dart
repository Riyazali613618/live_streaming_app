// presentation/providers/providers.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/remote/live_stream_api.dart';
import '../../data/repository/live_stream_repository.dart';
import '../../domain/entity/live_stream_entity.dart';
import '../../domain/usecase/get_live_streams_use_case.dart';
import 'live_stream_notifier.dart';

// Dio Instance
final dioProvider = Provider((ref) => Dio());

// API Provider
final liveStreamApiProvider = Provider(
  (ref) => LiveStreamApi(ref.watch(dioProvider)),
);

// Repository Provider
final liveStreamRepositoryProvider = Provider<LiveStreamRepository>(
  (ref) => LiveStreamRepositoryImpl(ref.watch(liveStreamApiProvider)),
);

// Use Case Provider
final getLiveStreamsUseCaseProvider = Provider(
  (ref) => GetLiveStreamsUseCase(ref.watch(liveStreamRepositoryProvider)),
);

// State Notifier Provider (The main state manager)
final reelsNotifierProvider =
    StateNotifierProvider<
      LiveStreamNotifier,
      AsyncValue<List<LiveStreamEntity>>
    >((ref) => LiveStreamNotifier(ref.watch(getLiveStreamsUseCaseProvider)));
