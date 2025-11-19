import 'package:flutter/material.dart';
import 'package:live_stream_chat/presentation/live_stream_overlay_widget.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    implements StageActionListener {
  String? createLoadingText;
  String? viewLoadingText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            ElevatedButton(
              onPressed: createLoadingText == null
                  ? () async {
                      setState(
                        () => createLoadingText = 'Creating Livestream...',
                      );
                      await _createLivestream();
                      setState(() => createLoadingText = null);
                    }
                  : null,
              child: Text(createLoadingText ?? 'Create a Livestream'),
            ),
            ElevatedButton(
              onPressed: viewLoadingText == null
                  ? () {
                      setState(() => viewLoadingText = 'Joining Livestream...');
                      _viewLivestream();
                      setState(() => viewLoadingText = null);
                    }
                  : null,
              child: Text(viewLoadingText ?? 'View a Livestream'),
            ),
            ElevatedButton(
              onPressed: viewLoadingText == null
                  ? () {
                      if (call != null) call!.leave();
                    }
                  : null,
              child: Text(viewLoadingText ?? 'Leave Call'),
            ),
          ],
        ),
      ),
    );
  }

  Call? call;
  String callId = "HlGs0tpPesRFmQEsd10pM";
  String hostCallId = "HlGs0tpPesRFmQEsd10pM";

  /*
  String callId = "HlGs0tpPesRFmQEsd10pM";
  String hostCallId = "HlGs0tpPesRFmQEsd10pM";
*/

  Future<void> _createLivestream() async {
    final call = StreamVideo.instance.makeCall(
      callType: StreamCallType.liveStream(),
      id: hostCallId,
    );

    // Set some default behaviour for how our devices should be configured once we join a call
    final connectOptions = CallConnectOptions(
      camera: TrackOption.enabled(),
      microphone: TrackOption.enabled(),
    );

    // Our local app user can join and receive events
    call.join(connectOptions: connectOptions).then((value) {
      redirectUser(call);
    });
    this.call = call; // Store the call object for 'Leave Call' button
  }

  // ... inside _HomeScreenState ...

  Future<void> _viewLivestream() async {
    // Set up our call object using a consistent ID
    if (call != null && call!.isActiveCall) {
      call!.leave();
    }
    call = StreamVideo.instance.makeCall(
      callType: StreamCallType.liveStream(),
      id: callId, // Use the same ID as the host
    );

    final result = await call!.getOrCreate(); // Ensure the call object exists

    if (result.isSuccess) {
      final connectOptions = CallConnectOptions(
        camera: TrackOption.disabled(), // Viewer should not publish video
        microphone: TrackOption.disabled(), // Viewer should not publish audio
      );

      final joinResult = await call!.join(connectOptions: connectOptions);
      if (joinResult case Failure failure) {
        debugPrint('Not able to join the call: ${failure.error}');
        return;
      }
      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Custom Livestream View'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  call!.leave();
                  Navigator.of(context).pop();
                },
              ),
            ),
            // --- CORE CUSTOMIZATION IMPLEMENTATION ---
            body: LivestreamPlayer(
              call: call!,
              showParticipantCount: true,
              startInFullscreenMode: true,
              livestreamControlsBuilder: (context, call, callState) {
                return Column(
                  children: [
                    Expanded(
                      child: LiveStreamOverlayWidget(
                        call: call,
                        participantsCount: 2,
                        hostName: "DDDD",
                        stageActionListener: this,
                      ),
                    ),
                    if (showVideo)
                      Expanded(
                        child: StreamVideoRenderer(
                          call: call,
                          participant: call.state.value.callParticipants
                              .firstWhere(
                                (element) =>
                                    element.userId != "Harsh_Atrociraptor",
                              ),
                          videoTrackType: SfuTrackType.video,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    if (call != null) {
      call!.leave();
    }
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> redirectUser(Call _call) async {
    // 1. ⚠️ Add a small delay (e.g., 500ms) here!
    // This allows the local client's video track to become available
    // and populate the callParticipants list before the LiveStreamScreen is built.
    await Future.delayed(const Duration(milliseconds: 500));

    // You could also wait for the participant list to update, but a short delay is often simpler.

    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            LivestreamContent1(call: _call, callState: _call.state.value),
      ),
      /*
      MaterialPageRoute(
        builder: (context) =>
            LivestreamContent(call: _call, callState: _call.state.value),
      ),
*/
    );
  }

  // This is the logic that needs to be inside your StageActionListener implementation:

  bool showVideo = false;

  void onClick({required bool isAudioOnly}) async {
    // Assume 'call' is available here (e.g., passed to the HomeScreen or StageActionListener).

    if (call == null) {
      // Handle error: call not available
      return;
    }

    // 1. Request Role Promotion (e.g., to 'guest' or 'publisher')
    // This is a critical step that gives the user permission to publish.
    // The exact role name depends on your setup, but 'guest' is common for streamers.
    try {
      // NOTE: If you are using Stage Access Requests, you might use
      // call.requestStageAccess(isAudioOnly: isAudioOnly);
      // Otherwise, you directly promote them:

      await call!.updateCallMembers(
        updateMembers: [
          UserInfo(id: call!.state.value.currentUserId, role: "guest"),
        ],
      );
      // 2. Enable Microphone
      await call!.setMicrophoneEnabled(enabled: true);

      // 3. Enable Camera if requesting video stage access
      await call!.setCameraEnabled(enabled: true);

      showVideo = !showVideo;
      setState(() {});
      // Success message/navigation (optional)
      print('Successfully joined the stage!');
    } catch (e) {
      // Handle error (e.g., show a dialog if the promotion failed)
      print('Error joining stage: $e');
    }
  }
}

class LivestreamContent1 extends StatefulWidget {
  final Call call;
  final CallState callState;

  const LivestreamContent1({
    super.key,
    required this.call,
    required this.callState,
  });

  @override
  State<LivestreamContent1> createState() => _LivestreamContent1State();
}

class _LivestreamContent1State extends State<LivestreamContent1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return LivestreamContent(
      call: widget.call,
      callState: widget.call.state.value,
    );
  }
}

abstract class StageActionListener {
  void onClick({required bool isAudioOnly});
}
