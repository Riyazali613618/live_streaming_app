import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

/// A custom widget to dynamically render video feeds for the active participants.
///
/// It prioritizes rendering the video feed of the main broadcaster (if present)
/// and then fills the remaining slots with other participants who are publishing.
class CustomVideoRenderer extends StatelessWidget {
  final Call call;

  const CustomVideoRenderer({super.key, required this.call});

  @override
  Widget build(BuildContext context) {
    // FIX: Listen to the entire CallState stream and extract the participants
    // inside the builder, which guarantees the 'callParticipants' list is available.
    return StreamBuilder<CallState>(
      stream: call.state.valueStream, // Listen to the entire CallState object
      builder: (context, snapshot) {
        // FIX: Using 'callParticipants' based on the CallState source code
        final allParticipants = snapshot.data?.callParticipants ?? [];

        if (allParticipants.isEmpty && snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // 1. Identify the Main Broadcaster (Host)
        // FIX: Check if the 'roles' list contains 'host', based on the CallParticipantState definition.
        final mainBroadcaster = allParticipants.firstWhereOrNull(
              (p) => p.roles.contains('host') && p.videoTrack != null,
        ) ?? allParticipants.firstOrNull; // Fallback to the first person

        // 2. Identify all other speakers (Guests, co-hosts, etc.) who have video tracks
        final otherSpeakers = allParticipants
            .where((p) =>
        p.videoTrack != null &&
            p.userId != mainBroadcaster?.userId)
            .toList();

        // 3. Include the local user if they are publishing (i.e., they are on stage)
        // FIX: Find the local participant directly in the list to guarantee the correct CallParticipantState type.
        final localParticipant = allParticipants.firstWhereOrNull((p) => p.isLocal);

        if (localParticipant != null && localParticipant.videoTrack != null) {
          // If the local user is publishing video, and they aren't already identified
          // as the main broadcaster, we treat them as an 'other speaker'.
          if (localParticipant.userId != mainBroadcaster?.userId) {
            // Check if the local participant is already in the list
            if (!otherSpeakers.any((p) => p.userId == localParticipant.userId)) {
              otherSpeakers.insert(0, localParticipant);
            }
          }
        }

        // Ensure we only take up to 3 speakers in total for this simple layout
        final participantsToRender = [
          if (mainBroadcaster != null) mainBroadcaster,
          ...otherSpeakers.take(2)
        ].whereNotNull().toSet().toList(); // Use a Set to ensure uniqueness

        // --- Layout Decision ---
        return _buildVideoLayout(participantsToRender);
      },
    );
  }

  /// Builds the layout based on the number of participants publishing video.
  Widget _buildVideoLayout(List<CallParticipantState> participants) {
    if (participants.isEmpty) {
      return const Center(
        child: Text(
          'Waiting for the host or guests to publish video.',
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      );
    }

    // Always prioritize the first participant (the main broadcaster)
    final mainParticipant = participants.first;
    final otherParticipants = participants.skip(1).toList();

    return Column(
      children: [
        // Main Broadcaster View
        Expanded(
          flex: 4,
          child: _renderVideo(mainParticipant, isMain: true),
        ),

        // Side-by-Side Views for Guests/Local User
        if (otherParticipants.isNotEmpty)
          Expanded(
            flex: 1,
            child: Row(
              children: otherParticipants.map((p) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _renderVideo(p, isMain: false),
                ),
              )).toList(),
            ),
          ),
      ],
    );
  }

  /// Renders a single participant's video feed.
  Widget _renderVideo(CallParticipantState participant, {required bool isMain}) {
    // IMPORTANT: Check for videoTrack != null before rendering!
    // We only proceed if a video track state exists (meaning the user is publishing video)
    if (participant.videoTrack == null) {
      // Fallback for participants who are audio-only or not publishing video
      return Center(
        child: CircleAvatar(
          radius: isMain ? 80 : 40,
          backgroundColor: Colors.blueGrey,
          child: Text(
            participant.name.substring(0, 1),
            style: TextStyle(fontSize: isMain ? 48 : 24, color: Colors.white),
          ),
        ),
      );
    }

    // The StreamVideoRenderer widget handles the complex rendering of the video track
    // FIX: Use the correct constructor parameters: 'call' and 'videoTrackType'.
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isMain ? Colors.yellow.shade700 : Colors.blue.shade700,
          width: isMain ? 4.0 : 2.0,
        ),
        borderRadius: BorderRadius.circular(12),
        color: Colors.black,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            // The core video rendering widget
            StreamVideoRenderer(
              call: call, // Pass the required StreamCall object
              participant: participant,
              videoTrackType: SfuTrackType.video, // Specify the main video track
              videoFit: VideoFit.cover, // Use the correct property name for fit
            ),
            // Name tag for the participant
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  // Name is a field on CallParticipantState
                  participant.name,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            // Show audio status
            if (participant.audioTrack == null || participant.audioTrack!.muted)
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.mic_off,
                  color: Colors.red.shade700,
                  size: isMain ? 32 : 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}