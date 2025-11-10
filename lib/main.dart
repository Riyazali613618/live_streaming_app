// ignore: dangling_library_doc_comments
/// Sample app for the Stream Livestreaming tutorial.
///
/// This project is a minimal example used in the tutorial to demonstrate
/// basic setup and usage. You can test it with demo credentials or replace them with your own
///
/// After updating the values below, run the app on a device or emulator.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_stream_chat/presentation/reels_screen.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

import 'home_screen.dart';

Future<void> main() async {
  // Ensure Flutter is able to communicate with Plugins
  WidgetsFlutterBinding.ensureInitialized();

  /// Replace the values below with your own Stream API keys and sample user data if you want to test your Stream app.
  /// For development, you can generate user tokens with our online tool: https://getstream.io/chat/docs/flutter-dart/tokens_and_authentication/#manually-generating-tokens
  /// For production apps, generate tokens on your server rather than in the client.
  StreamVideo(
    'mmhfdzb5evj2',
    user: const User(
      info: UserInfo(name: 'Shahbaz', id: 'Aspiring_Neighbor', role: 'user'),
    ),
    userToken:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3Byb250by5nZXRzdHJlYW0uaW8iLCJzdWIiOiJ1c2VyL0FzcGlyaW5nX05laWdoYm9yIiwidXNlcl9pZCI6IkFzcGlyaW5nX05laWdoYm9yIiwidmFsaWRpdHlfaW5fc2Vjb25kcyI6NjA0ODAwLCJpYXQiOjE3NjI1ODE0MDcsImV4cCI6MTc2MzE4NjIwN30.A1jFSc1PEigS39rlZLjgaaQn25gl6PBP9SMN9jq5nu0',
  );

  runApp(const MaterialApp(home: HomeScreen()));

  //TODO START AND VIEW DUMMY STREAM////////////////////////////////////////////
  /*StreamVideo(
    'mmhfdzb5evj2',
    user: const User(
      info: UserInfo(name: 'Shahbaz', id: 'Aspiring_Neighbor', role: 'user'),
    ),
    userToken:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3Byb250by5nZXRzdHJlYW0uaW8iLCJzdWIiOiJ1c2VyL0FzcGlyaW5nX05laWdoYm9yIiwidXNlcl9pZCI6IkFzcGlyaW5nX05laWdoYm9yIiwidmFsaWRpdHlfaW5fc2Vjb25kcyI6NjA0ODAwLCJpYXQiOjE3NjI1ODE0MDcsImV4cCI6MTc2MzE4NjIwN30.A1jFSc1PEigS39rlZLjgaaQn25gl6PBP9SMN9jq5nu0',
  );

   runApp(const MaterialApp(home: HomeScreen()));
 */
}
