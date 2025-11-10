// presentation/widgets/live_player_widget.dart

import 'package:flutter/material.dart';
import 'package:live_stream_chat/data/model/live_stream_model.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

import '../../domain/entity/live_stream_entity.dart';
import '../live_stream_overlay_widget.dart';

class LivePlayerWidget extends StatefulWidget {
  final Data stream;
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
      id: widget.stream.getStreamLivestreamId??"", // Unique Stream ID
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
      connectOptions: CallConnectOptions(
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
    return LivestreamPlayer(
      call: _call,
      showParticipantCount: false,
      startInFullscreenMode: true,
      livestreamControlsBuilder: (context, call, isFullScreen) {
        return LiveStreamOverlayWidget(
          participantsCount: call.state.value.callParticipants.length,
          hostName: call.state.value.createdByUser.name ?? "",
        );
      },
    );
  }

  Widget _buildPlaceholder({
    required String message,
    Color backgroundColor = Colors.black,
  }) {
    return Stack(
      children: [
        Container(
          color: backgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.live_tv, color: Colors.white54, size: 60),
                const SizedBox(height: 16),
                Text(message, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        LiveStreamOverlayWidget(
          participantsCount: 0,
          hostName:  "",
        )
      ],
    );
  }
}
