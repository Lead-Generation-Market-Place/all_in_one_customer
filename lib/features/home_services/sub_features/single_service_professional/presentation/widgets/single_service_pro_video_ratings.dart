import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:video_player/video_player.dart';

class SingleServiceProVideoRatings extends StatefulWidget {
  const SingleServiceProVideoRatings({super.key});

  @override
  State<SingleServiceProVideoRatings> createState() =>
      _SingleServiceProVideoRatingsState();
}

class _SingleServiceProVideoRatingsState
    extends State<SingleServiceProVideoRatings> {
  late VideoPlayerController _videoPlayerController;
  String _videoUrl = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  late ChewieController _chewieController;

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(_videoUrl))
          ..initialize().then((value) {
            setState(() {
              SmartDialog.showToast('Video Loaded Successfully');
            });
          });

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: false,
      looping: false,
      allowMuting: true,
      showControls: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child:
              _chewieController != null &&
                  _chewieController!.videoPlayerController.value.isInitialized
              ? Chewie(controller: _chewieController!)
              : const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}
