import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'trimmer.dart';

class VideoViewer extends StatefulWidget {
  /// The Trimmer instance controlling the data.
  final Trimmer trimmer;

  /// For specifying the color of the video
  /// viewer area border. By default it is set to `Colors.transparent`.
  final Color borderColor;

  /// For specifying the border width around
  /// the video viewer area. By default it is set to `0.0`.
  final double borderWidth;

  /// For specifying a padding around the video viewer
  /// area. By default it is set to `EdgeInsets.all(0.0)`.
  final EdgeInsets padding;

  /// For showing the video playback area.
  ///
  /// This only contains optional parameters. They are:
  ///
  /// * [borderColor] for specifying the color of the video
  /// viewer area border. By default it is set to `Colors.transparent`.
  ///
  ///
  /// * [borderWidth] for specifying the border width around
  /// the video viewer area. By default it is set to `0.0`.
  ///
  ///
  /// * [padding] for specifying a padding around the video viewer
  /// area. By default it is set to `EdgeInsets.all(0.0)`.
  ///
  VideoViewer({
    required this.trimmer,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.padding = const EdgeInsets.all(0.0),
  });

  @override
  _VideoViewerState createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  /// Quick access to VideoPlayerController, only not null after [TrimmerEvent.initialized]
  /// has been emitted.
  VideoPlayerController? get videoPlayerController =>
      widget.trimmer.videoPlayerController;

  @override
  void initState() {
    widget.trimmer.eventStream.listen((event) {
      if (event == TrimmerEvent.initialized) {
        //The video has been initialized, now we can load stuff
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _controller = videoPlayerController;
    final Size size = MediaQuery.of(context).size;
    print('videoHeight: ${widget.trimmer.videoHeight}');
    return (_controller != null && _controller.value.isInitialized) &&
            (widget.trimmer.videoHeight != null &&
                widget.trimmer.videoWidth != null)
        ? FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              height: widget.trimmer.videoHeight,
              width: widget.trimmer.videoWidth,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          )
        : Container();

    // ? Center(
    //     child: Padding(
    //       padding: widget.padding,
    //       child: AspectRatio(
    //         aspectRatio: _controller.value.aspectRatio,
    //         child: _controller.value.isInitialized
    //             ? Container(
    //                 decoration: BoxDecoration(
    //                   border: Border.all(
    //                     width: widget.borderWidth,
    //                     color: widget.borderColor,
    //                   ),
    //                 ),
    //                 child: VideoPlayer(_controller),
    //               )
    //             : Container(
    //                 child: Center(
    //                   child: CircularProgressIndicator(
    //                     backgroundColor: Colors.white,
    //                   ),
    //                 ),
    //               ),
    //       ),
    //     ),
    //   )
    // : Container();
  }

  @override
  void dispose() {
    widget.trimmer.dispose();
    super.dispose();
  }
}
