import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:yumusic/consts.dart';

class VideoScreen extends StatefulWidget {
  final String videoId, image, title;

  const VideoScreen({required this.videoId, required this.image, required this.title});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Inicialize o controlador do YoutubePlayer com o vídeo especificado pelo ID
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    // Lembre-se de descartar o controlador ao sair da tela
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
        color: kPrimaryColor,
            height:MediaQuery.of(context).padding.top,
          ),
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
          ),

        ],
      ),
    );
  }
}
