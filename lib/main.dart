// ignore: dangling_library_doc_comments
/// Sample app for the Stream Livestreaming tutorial.
///
/// This project is a minimal example used in the tutorial to demonstrate
/// basic setup and usage. You can test it with demo credentials or replace them with your own
///
/// After updating the values below, run the app on a device or emulator.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

import 'home_screen.dart';

String key = "mmhfdzb5evj2";
String token =
    ""
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3Byb250by5nZXRzdHJlYW0uaW8iLCJzdWIiOiJ1c2VyL0hhcnNoX0F0cm9jaXJhcHRvciIsInVzZXJfaWQiOiJIYXJzaF9BdHJvY2lyYXB0b3IiLCJ2YWxpZGl0eV9pbl9zZWNvbmRzIjo2MDQ4MDAsImlhdCI6MTc2MzM5OTkyNCwiZXhwIjoxNzY0MDA0NzI0fQ.8N9bFda5TOPQ8mhISkbJpqbPxI-iZOifbzWUMeQjVTE";
String idUser = "Harsh_Atrociraptor";

Future<void> main() async {
  // Ensure Flutter is able to communicate with Plugins
  WidgetsFlutterBinding.ensureInitialized();

  StreamVideo(
    key,
    user: User(
      info: UserInfo(name: 'bbb', id: idUser, role: 'admin'),
    ),
    userToken: token,
  );
  // runApp(const MaterialApp(home: HomeScreen()));
  runApp(const ProviderScope(child: MaterialApp(home: HomeScreen())));

  /*  StreamVideo(
    '23xersqfz4j9',
    user: const User(
      info: UserInfo(name: 'Shahbaz', id: '220e402f-02cb-48cb-8951-bb7032d8d83e', role: 'user'),
    ),
    userToken:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMjIwZTQwMmYtMDJjYi00OGNiLTg5NTEtYmI3MDMyZDhkODNlIiwiZXhwIjoxNzYyODU0MjIxLCJpYXQiOjE3NjI3Njc4MjB9.noQ3I-N55Dv1skZEbhNe9ucWnVZCqOfdT34_rfqM0yA',
  );

  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: ReelsScreen(),
      ),
    ),
  );*/
}
