// presentation/reels_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_stream_chat/presentation/provider/providers.dart';
import 'package:live_stream_chat/presentation/widget/live_player_widget.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

class ReelsScreen extends ConsumerStatefulWidget {
  const ReelsScreen({super.key});

  @override
  ConsumerState<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends ConsumerState<ReelsScreen> {
  int _currentPageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final streamsAsync = ref.watch(reelsNotifierProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,

      body: streamsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error loading streams: $e')),
        data: (streams) {
          if (streams.isEmpty) {
            return const Center(child: Text('No active livestreams found.'));
          }

          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            pageSnapping: true,
            itemCount: streams.length,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex =
                    index; // Update index to trigger play/stop logic
              });
            },
            itemBuilder: (context, index) {
              final stream = streams[index];
              return LivePlayerWidget(
                stream: stream,
                // This is the core logic for requirement #3: stop previous stream and play current
                isCurrentlyVisible: index == _currentPageIndex,
              );
            },
          );
        },
      ),
    );
  }
}
