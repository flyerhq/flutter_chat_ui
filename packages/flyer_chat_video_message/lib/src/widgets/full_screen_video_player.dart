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
  final double? aspectRatio;

  const FullscreenVideoPlayer({
    super.key,
    required this.source,
    required this.heroTag,
    this.backgroundColor,
    this.loadingIndicatorColor,
    this.aspectRatio,
  });

  @override
  State<FullscreenVideoPlayer> createState() => _FullscreenVideoPlayerState();
}

class _FullscreenVideoPlayerState extends State<FullscreenVideoPlayer> {
  late VideoPlayerController _videoPlayer;
  late ChewieController? _chewieController;
  late double _aspectRatio;

  @override
  void initState() {
    super.initState();
    _aspectRatio = widget.aspectRatio ?? 16 / 9;
    _initializeVideoPlayerAsync();
  }

  Future<void> _initializeVideoPlayerAsync() async {
    if (isNetworkSource(widget.source)) {
      _videoPlayer = VideoPlayerController.networkUrl(Uri.parse(widget.source));
    } else {
      _videoPlayer = VideoPlayerController.file(File(widget.source));
    }

    await _videoPlayer.initialize();
    if (mounted) {
      setState(() {
        _aspectRatio = _videoPlayer.value.aspectRatio;
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayer,
          autoPlay: true,
          allowFullScreen: false,
          autoInitialize: false,
        );
      });
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayer.dispose();
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
          child: Center(
            child: AspectRatio(
              aspectRatio: _aspectRatio,
              child:
                  _videoPlayer.value.isInitialized && _chewieController != null
                      ? Chewie(controller: _chewieController!)
                      : Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color: widget.loadingIndicatorColor,
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
