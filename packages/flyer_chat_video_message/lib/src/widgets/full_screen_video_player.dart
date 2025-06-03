import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../helpers/is_network_source.dart';

class FullscreenVideoPlayer extends StatefulWidget {
  final String source;
  final String heroTag;
  final Color? backgroundColor;
  final Color? loadingIndicatorColor;

  const FullscreenVideoPlayer({
    super.key,
    required this.source,
    required this.heroTag,
    this.backgroundColor,
    this.loadingIndicatorColor,
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
    _initializeVideoPlayerAsync();
  }

  Future<void> _initializeVideoPlayerAsync() async {
    if (isNetworkSource(widget.source)) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.source));
    } else {
      _controller = VideoPlayerController.file(File(widget.source));
    }

    await _controller.initialize();
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: true,
        allowFullScreen: false,
        autoInitialize: false,
      );
    });
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
          child:
              _controller.value.isInitialized
                  ? Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Chewie(controller: _chewieController),
                    ),
                  )
                  : Center(
                    child: CircularProgressIndicator(
                      color: widget.loadingIndicatorColor,
                    ),
                  ),
        ),
      ),
    );
  }
}
