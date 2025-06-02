import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullscreenVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String heroTag;
  final Color? backgroundColor;

  const FullscreenVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.heroTag,
    this.backgroundColor,
  });

  @override
  State<FullscreenVideoPlayer> createState() => _FullscreenVideoPlayerState();
}

class _FullscreenVideoPlayerState extends State<FullscreenVideoPlayer> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      allowFullScreen: false,
      autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Hero(
          tag: widget.heroTag,
          child: Center(child: Chewie(controller: _chewieController)),
        ),
      ),
    );
  }
}
