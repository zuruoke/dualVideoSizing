import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reminisce/trimmer/file_formats.dart';
import 'package:reminisce/trimmer/trim_editor.dart';
import 'package:reminisce/trimmer/trimmer.dart' as trim1;
import 'package:reminisce/trimmer/trimmer.dart' as trim2;
import 'package:reminisce/trimmer/video_viewer.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class TrimmerView extends StatefulWidget {
  File video1;
  File video2;
  final Size screenSize;

  TrimmerView(
      {required this.video1, required this.video2, required this.screenSize});

  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  // final trim1.Trimmer _trimmer1 = trim1.Trimmer(
  //     deviceHeight: 781.0909090909091, deviceWidth: 392.72727272727275);
  // final trim2.Trimmer _trimmer2 = trim2.Trimmer(
  //     deviceHeight: 781.0909090909091, deviceWidth: 392.72727272727275);

  late final trim1.Trimmer _trimmer1;
  late final trim2.Trimmer _trimmer2;

  double _startValue1 = 0.0;
  double _endValue1 = 0.0;
  double _startValue2 = 0.0;
  double _endValue2 = 0.0;

  bool _isPlaying1 = false;
  bool _isPlaying2 = false;
  bool _progressVisibility = false;
  late File savedVideo1;
  late File savedVideo2;
  bool onTopVideo = true;
  int index = 0;

  void _loadVideo() {
    _trimmer1.loadVideo(videoFile: widget.video1);
    _trimmer2.loadVideo(videoFile: widget.video2);
  }

  @override
  void initState() {
    super.initState();
    _trimmer1 = trim1.Trimmer(
        deviceHeight: widget.screenSize.height,
        deviceWidth: widget.screenSize.width);
    _trimmer2 = trim2.Trimmer(
        deviceHeight: widget.screenSize.height,
        deviceWidth: widget.screenSize.width);
    _loadVideo();
  }

  Future _saveVideo1() async {
    // setState(() {
    //   _progressVisibility = true;
    // });

    await _trimmer1
        .saveTrimmedVideo(
            startValue: _startValue1,
            endValue: _endValue1,
            outputFormat: FileFormat.mp4)
        .then((filePath) {
      setState(() {
        savedVideo1 = File(filePath);
      });
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => Text("data")));
  }

  Future _saveVideo2() async {
    // setState(() {
    //   _progressVisibility = true;
    // });

    await _trimmer1
        .saveTrimmedVideo(
            startValue: _startValue1,
            endValue: _endValue1,
            outputFormat: FileFormat.mp4)
        .then((filePath) {
      setState(() {
        savedVideo1 = File(filePath);
      });
    });

    await _trimmer2
        .saveTrimmedVideo(
            startValue: _startValue1,
            endValue: _endValue1,
            outputFormat: FileFormat.mp4)
        .then((filePath) {
      setState(() {
        savedVideo2 = File(filePath);
      });
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => Text("data")));
  }

  _topRowWidget() {
    return Positioned(
      top: 30,
      left: 10,
      right: 20,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                // setState(() {
                //   widget.video = null;
                //   widget.trimmer = null;
                // });
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 1,
                  primary: Colors.pink.shade400,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(6.0),
                  ))),
              child: Text(
                'Next',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: _saveVideo2,
            ),
          ],
        ),
      ),
    );
  }

  _trimEditor() {
    final mq = MediaQuery.of(context).size;
    return Positioned(
      bottom: 60,
      left: 5,
      right: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TrimEditor(
              trimmer: _trimmer1,
              maxVideoLength: const Duration(seconds: 30),
              viewerHeight: 60.0,
              viewerWidth: mq.width,
              onChangeStart: (value) {
                _startValue1 = value;
              },
              onChangeEnd: (value) {
                _endValue1 = value;
              },
              onChangePlaybackState: (value) {
                setState(() {
                  _isPlaying1 = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.transparent),
            onPressed: () async {
              bool playbackState = await _trimmer1.videPlaybackControl(
                startValue: _startValue1,
                endValue: _endValue1,
              );
              setState(() {
                _isPlaying1 = playbackState;
              });
            },
            child: _isPlaying1
                ? Icon(
                    Icons.pause,
                    size: 80.0,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.play_arrow,
                    size: 80.0,
                    color: Colors.white,
                  ),
          )
        ],
      ),
    );
  }

  videoPlayback1() async {
    bool playbackState = await _trimmer1.videPlaybackControl(
      startValue: _startValue1,
      endValue: _endValue1,
    );

    setState(() {
      _isPlaying1 = playbackState;
    });
  }

  videoPlayback2() async {
    bool playbackState = await _trimmer2.videPlaybackControl(
      startValue: _startValue1,
      endValue: _endValue1,
    );

    setState(() {
      _isPlaying2 = playbackState;
    });
  }

  dualTrimEditor() {
    print(onTopVideo);
    final mq = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: TrimEditor(
        trimmer: onTopVideo ? _trimmer1 : _trimmer2,
        maxVideoLength: const Duration(seconds: 30),
        viewerHeight: 60.0,
        viewerWidth: mq.width,
        onChangeStart: (value) {
          _startValue1 = value;
        },
        onChangeEnd: (value) {
          _endValue1 = value;
        },
        onChangePlaybackState: (value) {
          index == 0
              ? setState(() {
                  _isPlaying1 = value;
                })
              : setState(() {
                  _isPlaying2 = value;
                });
        },
      ),
    );
  }

  _dualVideoTrimmer() {
    final mq = MediaQuery.of(context).size;
    return Container(
      height: mq.height,
      width: mq.width,
      //alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    onTopVideo = true;
                  });
                  if (_isPlaying2) {
                    videoPlayback2();
                  }
                  videoPlayback1();
                },
                child: VideoViewer(
                  trimmer: _trimmer1,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    onTopVideo = false;
                  });
                  if (_isPlaying1) {
                    videoPlayback1();
                  }
                  videoPlayback2();
                },
                child: VideoViewer(
                  trimmer: _trimmer2,
                ),
              )
            ],
          ),
          _topRowWidget(),
          dualTrimEditor()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Builder(builder: (context) => _dualVideoTrimmer()));
  }
}
