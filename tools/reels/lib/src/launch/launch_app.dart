import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:reels/src/app/editor_page.dart';
import 'package:reels/src/launch/video_builder.dart';

Future<void> runVideo(List<String> args, VideoBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(ReelsApp(builder: builder));
}

class ReelsApp extends StatelessWidget {
  const ReelsApp({required this.builder, super.key});

  final VideoBuilder builder;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Reels',
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(useMaterial3: true),
    home: EditorPage(builder: builder),
  );
}
