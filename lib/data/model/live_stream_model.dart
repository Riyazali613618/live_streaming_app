// data/models/live_stream_model.dart

import '../../domain/entity/live_stream_entity.dart';

class LiveStreamModel extends LiveStreamEntity {
  LiveStreamModel({
    required super.streamId,
    required super.userId,
    required super.title,
    required super.streamType,
  });

  factory LiveStreamModel.fromJson(Map<String, dynamic> json) {
    // Assuming the API returns keys like 'stream_id' and 'user_id'
    return LiveStreamModel(
      streamId: json['stream_id'] as String? ?? 'default_stream_id',
      userId: json['user_id'] as String? ?? 'default_user_id',
      title: json['title'] as String? ?? 'Untitled Stream',
      streamType: json['lecture_type'] as String? ?? 'open_live',
    );
  }
}