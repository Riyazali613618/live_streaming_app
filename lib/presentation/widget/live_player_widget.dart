// presentation/widgets/live_player_widget.dart
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

import '../../domain/entity/live_stream_entity.dart';
import '../live_stream_overlay_widget.dart';

class LivePlayerWidget extends StatefulWidget {
  final LiveStreamEntity stream;
  final bool isCurrentlyVisible; // New flag to control play/stop

  const LivePlayerWidget({
    super.key,
    required this.stream,
    required this.isCurrentlyVisible,
  });

  @override
  State<LivePlayerWidget> createState() => _LivePlayerWidgetState();
}

class _LivePlayerWidgetState extends State<LivePlayerWidget> {
  late final Call _call;
  bool _isJoined = false;

  @override
  void initState() {
    super.initState();
    // 1. Initialize the Call object
    _call = StreamVideo.instance.makeCall(
      callType: StreamCallType.liveStream(),
      id: widget.stream.streamId, // Unique Stream ID
    );
    // 2. Initial check for visibility
    if (widget.isCurrentlyVisible) {
      _initAndJoinCall();
    }
  }

  @override
  void didUpdateWidget(covariant LivePlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 3. Handle play/stop logic when visibility changes
    if (widget.isCurrentlyVisible != oldWidget.isCurrentlyVisible) {
      if (widget.isCurrentlyVisible) {
        _initAndJoinCall(); // Play current stream
      } else {
        _leaveCall(); // Stop previous stream
      }
    }
  }

  Future<void> _initAndJoinCall() async {
    if (_isJoined) return; // Prevent double joining

    // Ensure call exists and then join as a viewer
    await _call.getOrCreate();
    await _call.join(
      connectOptions:  CallConnectOptions(
        camera: TrackOption.disabled(),
        microphone: TrackOption.disabled(),
      ),
    );

    if (mounted) setState(() => _isJoined = true);
  }

  Future<void> _leaveCall() async {
    if (!_isJoined) return;
    await _call.leave();
    if (mounted) setState(() => _isJoined = false);
  }

  @override
  void dispose() {
    _leaveCall(); // Always leave call when widget is destroyed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isJoined) {
      // Show loading or placeholder while joining
      return _buildPlaceholder(
        message: 'Joining Stream...',
        backgroundColor: Colors.black,
      );
    }

    // Use StreamCallContainer and StreamBuilder for custom rendering
    return Stack(
      children: [StreamCallContainer(
          call: _call,
          callContentWidgetBuilder: (innerContext, call) {
            return StreamBuilder<CallState>(
              stream: call.state.valueStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return _buildPlaceholder(message: 'Loading Call State...');
                }
                final callState = snapshot.data!;

                // Find the video track
                final streamingParticipant = callState.callParticipants
                    .firstWhereOrNull(
                      (p) => p.publishedTracks.containsKey(TrackType.video),
                );

                final SfuTrackTypeVideo? videoTrack = streamingParticipant != null
                    ? call.getTrack(
                  streamingParticipant.trackIdPrefix,
                  SfuTrackType.video,
                ) as SfuTrackTypeVideo?
                    : null;

                if (videoTrack != null && videoTrack.isVideo) {
                  // Stream Active: Show Live Video
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      StreamVideoRenderer(
                        videoTrackType: videoTrack,
                        videoFit: VideoFit.cover,
                        call: call,
                        participant: streamingParticipant!,
                      ),
                      // Overlay: Like, Comment, Share Buttons
                      _buildReelOverlay(context, widget.stream),
                    ],
                  );
                }

                // Stream Inactive: Show Placeholder
                return _buildPlaceholder(
                  message: callState.status.isJoined
                      ? 'Stream Starting Soon...'
                      : 'Connecting...',
                );
              },

            );
          }),LiveStreamOverlayWidget()]
    );
  }

  Widget _buildPlaceholder(
      {required String message, Color backgroundColor = Colors.black}) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.live_tv, color: Colors.white54, size: 60),
            const SizedBox(height: 16),
            Text(message, style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget _buildReelOverlay(BuildContext context, LiveStreamEntity stream) {
    // This builds the Instagram-like UI elements
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dummy Like Button
            IconButton(icon: const Icon(Icons.favorite, color: Colors.white),
                onPressed: () {}),
            const Text('1.2K', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 16),
            // Dummy Comment Button
            IconButton(icon: const Icon(Icons.comment, color: Colors.white),
                onPressed: () {}),
            const Text('120', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 16),
            // Dummy Share Button
            IconButton(icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
