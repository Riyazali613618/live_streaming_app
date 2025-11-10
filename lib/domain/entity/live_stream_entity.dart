// domain/entities/live_stream_entity.dart
class LiveStreamEntity {
  final String streamId;
  final String userId; // Stream host's user ID
  final String title;
  final String streamType; // e.g., 'open_live'

  LiveStreamEntity({
    required this.streamId,
    required this.userId,
    required this.title,
    required this.streamType,
  });
}