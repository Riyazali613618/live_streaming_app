// data/repositories/live_stream_repository.dart
import '../../domain/entity/live_stream_entity.dart';
import '../model/live_stream_model.dart';
import '../remote/live_stream_api.dart';

abstract class LiveStreamRepository {
  Future<List<Data>> getLiveStreams();
}

class LiveStreamRepositoryImpl implements LiveStreamRepository {
  final LiveStreamApi _api;

  LiveStreamRepositoryImpl(this._api);

  @override
  Future<List<Data>> getLiveStreams() async {
    return _api.fetchStreams();
  }
}