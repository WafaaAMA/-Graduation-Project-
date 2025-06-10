import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GuidanceAwarenessPage extends StatefulWidget {
  @override
  _GuidanceAwarenessPageState createState() => _GuidanceAwarenessPageState();
}

class _GuidanceAwarenessPageState extends State<GuidanceAwarenessPage> {
  final String apiKey = 'AIzaSyDqR2497IDcp4WgqoiQ7ebPpljG6ICb-7k';
  final String playlistId = 'PLvd0isBh6beTimR5u73eLdNEQcqzrPaWh';
  List<String> videoIds = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=20&playlistId=$playlistId&key=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List;

      setState(() {
        videoIds = items
            .map((item) => item['snippet']['resourceId']['videoId'] as String)
            .toList();
        isLoading = false;
      });
    } else {
      throw Exception('فشل تحميل الفيديوهات');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guidance & Awareness'),
        backgroundColor: Color(0xFF199A8E), // AppBar color
      ),
      body: Container(
        color: Color(0xFFE8F3F1), // Background color
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: videoIds.length,
                itemBuilder: (context, index) {
                  final videoId = videoIds[index];
                  return Padding(
                    padding: const EdgeInsets.all(16.0), // Add padding for spacing
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12), // Rounded corners
                        border: Border.all(
                          color: Color(0xFF199A8E), // Border color same as AppBar
                          width: 3, // Border width
                        ),
                      ),
                      child: YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: videoId,
                          flags: YoutubePlayerFlags(
                            autoPlay: false,
                            mute: false,
                          ),
                        ),
                        showVideoProgressIndicator: true,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
