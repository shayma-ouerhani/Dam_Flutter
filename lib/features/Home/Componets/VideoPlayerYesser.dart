import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VideoPlayerYesser extends StatefulWidget {
  final String videoUrl;
  final Function(VideoPlayerController)? onSingleTap;
  final Function(VideoPlayerController, Offset)? onDoubleTap;
  final VoidCallback? onVideoDispose;
  final VoidCallback? onVideoGoBackground;

  const VideoPlayerYesser({
    Key? key,
    required this.videoUrl,
    this.onSingleTap,
    this.onDoubleTap,
    this.onVideoDispose,
    this.onVideoGoBackground,
  }) : super(key: key);

  @override
  _VideoPlayerYesserState createState() => _VideoPlayerYesserState();
}

class _VideoPlayerYesserState extends State<VideoPlayerYesser> {
  late VideoPlayerController _controller;
  bool _isThumbnailVisible = true;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isThumbnailVisible = false;
          });
          _controller
            ..play()
            ..setLooping(true);
        }
      }).catchError((error) {
        debugPrint("Erreur lors de l'initialisation du lecteur vidéo : $error");
      });

    _controller.addListener(_videoPlayerListener);
  }

  void _videoPlayerListener() {
    // Logique supplémentaire pour écouter les changements de l'état du lecteur vidéo
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSingleTap?.call(_controller);
        setState(() {
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
        });
      },
      onDoubleTapDown: (details) {
        widget.onDoubleTap?.call(_controller, details.localPosition);
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Thumbnail visible avant le chargement de la vidéo
          if (_isThumbnailVisible)
            CachedNetworkImage(
              imageUrl: widget.videoUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),

          // Vidéo une fois initialisée
          if (_controller.value.isInitialized)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          else if (!_isThumbnailVisible)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_videoPlayerListener);
    _controller.dispose();
    widget.onVideoDispose?.call();
    super.dispose();
  }

  @override
  void deactivate() {
    widget.onVideoGoBackground?.call();
    super.deactivate();
  }
}
