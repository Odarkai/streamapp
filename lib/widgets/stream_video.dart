import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Stream/video_player_page.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  Future<List<String>> fetchVideoUrls() async {
    List<String> videoUrls = [];
    final storage = FirebaseStorage.instance;
    final ListResult result = await storage.ref().child('videos').listAll();
    for (final ref in result.items) {
      final url = await ref.getDownloadURL();
      videoUrls.add(url);
    }
    return videoUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade900,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade900,
        title: const Text('Stream For Free'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, ),
        child: FutureBuilder<List<String>>(
          future: fetchVideoUrls(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error fetching videos'));
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final videoUrl = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerPage(videoUrl: videoUrl),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text('Video $index'),
                      leading: const Icon(Icons.video_library),
                    ),
                  );
                },
              );
            }
            return const Center(child: Text('No videos found'));
          },
        ),
      ),
    );
  }
}