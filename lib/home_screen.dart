import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
/*
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
*/
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
          ],
        ),
      ),
    );
  }

  late final Call call;

/*
  Future<void> _createLivestream() async {
    // Set up our call object
    call = StreamVideo.instance.makeCall(
      callType: StreamCallType.liveStream(),
      id: 'livestream-b941303c-9953-49c6-8ce4-87eff5835688',
    );

    // Create the call and set the current user as a host
    final result = await call.getOrCreate(
      members: [
        MemberRequest(
          userId: StreamVideo.instance.currentUser.id,
          role: 'host',
        ),
      ],
    );

    if (result.isFailure) {
      debugPrint('Not able to create a call.');
      return;
    }

    // Configure the call to allow users to join before it starts by setting a future start time
    // and specifying how many seconds in advance they can join via `joinAheadTimeSeconds`
    final updateResult = await call.update(
      startsAt: DateTime.now().toUtc().add(const Duration(seconds: 120)),
      backstage: const StreamBackstageSettings(
        enabled: true,
        joinAheadTimeSeconds: 120,
      ),
    );

    if (updateResult.isFailure) {
      debugPrint('Not able to update the call.');
      return;
    }

    // Set some default behaviour for how our devices should be configured once we join a call
    final connectOptions = CallConnectOptions(
      camera: TrackOption.enabled(),
      microphone: TrackOption.enabled(),
    );

    // Our local app user can join and receive events
    await call.join(connectOptions: connectOptions);

    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LiveStreamScreen(livestreamCall: call),
      ),
    );
  }
*/

  // ... inside _HomeScreenState ...

  Future<void> _viewLivestream() async {
    // Set up our call object using a consistent ID
    final call = StreamVideo.instance.makeCall(
      callType: StreamCallType.liveStream(),
      id: 'livestream-b941303c-9953-49c6-8ce4-87eff5835688', // Use the same ID as the host
    );

    final result = await call.getOrCreate(); // Ensure the call object exists

    if (result.isSuccess) {
      final connectOptions = CallConnectOptions(
        camera: TrackOption.disabled(), // Viewer should not publish video
        microphone: TrackOption.disabled(), // Viewer should not publish audio
      );

      final joinResult = await call.join(connectOptions: connectOptions);
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
                  call.leave();
                  Navigator.of(context).pop();
                },
              ),
            ),
            // --- CORE CUSTOMIZATION IMPLEMENTATION ---
            body: LivestreamPlayer(call: call, showParticipantCount: false,),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    if (call != null) {
      call.leave();
    }
    // TODO: implement dispose
    super.dispose();
  }
}
