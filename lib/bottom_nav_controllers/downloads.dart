import 'package:flutter/material.dart';

class VideoItem {
  final String videoTitle;
  final String videoUrl;

  VideoItem({required this.videoTitle, required this.videoUrl});
}

class Downloads extends StatefulWidget {
  const Downloads({super.key});

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {

  List<VideoItem> videoItems = [
    VideoItem(
      videoTitle: 'Citation',
      videoUrl: 'https://example.com/video1.mp4', // Replace with the actual video URL
    ),
    VideoItem(
      videoTitle: 'Blood and Water',
      videoUrl: 'https://example.com/video1.mp4', // Replace with the actual video URL
    ),
    // Add more video items as needed
  ];

  void removeVideoItem(int index) {
    setState(() {
      videoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade900,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: videoItems.length,
          itemBuilder: (context, index) {
            VideoItem videoItem = videoItems[index];
            return ListTile(
              leading: const Icon(Icons.video_collection),
              title: Text(videoItem.videoTitle),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => removeVideoItem(index),
              ),
            );
          },
        ),
      ),
    );
  }

}