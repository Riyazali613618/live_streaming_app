// domain/use_cases/get_live_streams_use_case.dart

import '../../data/repository/live_stream_repository.dart';
import '../entity/live_stream_entity.dart';

class GetLiveStreamsUseCase {
  final LiveStreamRepository _repository;

  GetLiveStreamsUseCase(this._repository);

  Future<List<LiveStreamEntity>> call() async {
    return _repository.getLiveStreams();
  }
}
