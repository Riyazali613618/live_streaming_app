// data/repositories/live_stream_repository.dart
import '../../domain/entity/live_stream_entity.dart';
import '../remote/live_stream_api.dart';

abstract class LiveStreamRepository {
  Future<List<LiveStreamEntity>> getLiveStreams();
}

class LiveStreamRepositoryImpl implements LiveStreamRepository {
  final LiveStreamApi _api;

  LiveStreamRepositoryImpl(this._api);

  @override
  Future<List<LiveStreamEntity>> getLiveStreams() async {
    return _api.fetchStreams();
  }
}