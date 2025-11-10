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
    '23xersqfz4j9',
    user: const User(
      info: UserInfo(name: 'Shahbaz', id: '220e402f-02cb-48cb-8951-bb7032d8d83e', role: 'user'),
    ),
    userToken:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMjIwZTQwMmYtMDJjYi00OGNiLTg5NTEtYmI3MDMyZDhkODNlIiwiZXhwIjoxNzYyNzA2MDA3LCJpYXQiOjE3NjI2MTk2MDZ9.NnP1niSG2aaETykv4xXd5W2-TkfoidQpULDBQ9DAdsk',
  );

  // runApp(const MaterialApp(home: HomeScreen()));
  // inside main()
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: ReelsScreen(),
      ),
    ),
  );
}
