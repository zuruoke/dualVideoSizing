import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final File video1;
  final File video2;
  final double screenHeight;
  final double screenWidth;

  VideoPlayerScreen({required this.video1, required this.video2, required this.screenHeight, required this.screenWidth});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  VideoPlayerController? controller1;
  VideoPlayerController? controller2;
  // late double initialVideo1Height;
  // late double initialVideo1Width;
  // late double initialVideo2Height;
  // late double initialVideo2Width;

  double? video1Height;
  double? video1Width;
  double? video2Height;
  double? video2Width;

  @override
  void initState() {
    print(widget.screenHeight);
    initializeVideos();
    // sizeVideo1();
    // sizeVideo2();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   final Size size = MediaQuery.of(context).size;
  //   print("ScreenSize: ${size.height}, ${size.width}");
  //   print("Video1Size: ${controller1!.value.size.height}");
  //   print("Video1Size: ${controller2!.value.size.height}");
  //   super.didChangeDependencies();
    
  // }

  initializeVideos(){
    controller1 = VideoPlayerController.file(widget.video1)
      ..addListener(() => setState((){}))
      ..setLooping(true)
      ..initialize().then((_){
        controller1!.play();
        sizeVideo1();
      });
    controller2 = VideoPlayerController.file(widget.video2)
      ..addListener(() => setState((){}))
      ..setLooping(true)
      ..initialize().then((_) {
        controller2!.play();
        sizeVideo2();
        });
  }

  // sizeVideo1() {
  //     int i = 0;
  //     while (controller1!.value.size.height > widget.screenHeight || controller1!.value.size.width > widget.screenWidth){
  //       video1Height = controller1!.value.size.height / 1.1;
  //       video1Width = controller1!.value.size.width / 1.1;
  //       i += 1;
  //       print(i);
  //     }
  //   }

  sizeVideo1(){
    double initialVideo1Height = controller1!.value.size.height;
    double initialVideo1Width = controller1!.value.size.width;
    int i = 0;
    if (initialVideo1Height > 0.5 * widget.screenHeight || initialVideo1Width > widget.screenWidth)
    while(initialVideo1Height > 0.5 * widget.screenHeight || initialVideo1Width > widget.screenWidth){
      if (i == 0){
      initialVideo1Height = initialVideo1Height / 1.5;
      initialVideo1Width = initialVideo1Width / 1.5;
      }
      else {
      initialVideo1Height = initialVideo1Height / 1.2;
      initialVideo1Width = initialVideo1Width / 1.2;
      }
      i += 1;
    }
    print(i);
    video1Height = initialVideo1Height;
    video1Width = initialVideo1Width;
  }

  sizeVideo2(){
    double initialVideo2Height = controller2!.value.size.height;
    double initialVideo2Width = controller2!.value.size.width;
    int i = 0;
    if (initialVideo2Height > 0.5 * widget.screenHeight || initialVideo2Width > widget.screenWidth)
    while(initialVideo2Height > 0.5 * widget.screenHeight || initialVideo2Width > widget.screenWidth){
      if (i == 0){
      initialVideo2Height = initialVideo2Height / 1.5;
      initialVideo2Width = initialVideo2Width / 1.5;
      }
      else {
      initialVideo2Height = initialVideo2Height / 1.1;
      initialVideo2Width = initialVideo2Width / 1.1;
      }
      i += 1;
    }
    print(i);
    video2Height = initialVideo2Height;
    video2Width = initialVideo2Width;
  }

  // sizeVideo2() {
  //     int i = 0;
  //     while (controller2!.value.size.height > widget.screenHeight || controller2!.value.size.width > widget.screenWidth){
  //       video2Height = controller2!.value.size.height / 1.1;
  //       video2Width = controller2!.value.size.width / 1.1;
  //       i +=1;
  //       print(i);
  //     }
  //   }
  

  @override
  void dispose() {
    controller1?.dispose();
    controller2?.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    controller1?.dispose();
    controller2?.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
     final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: 
      (controller1 != null && controller1!.value.isInitialized) && 
      (controller2 != null && controller2!.value.isInitialized) && 
      (video1Height != null && video1Width != null) && 
      (video2Height != null && video2Width != null)
      ? Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // GestureDetector(
                // onTap: (){
                //   showDialog(
                //     context: context, 
                //     builder: (ctx) {
                //       return Text("${video1Height.toString()}, ${video1Width.toString()} ",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold));
                //     }
                //   );
                // },
                // child: Container(
                //   height: 0.5 * size.height,
                //   width: size.width,
                //   child: AspectRatio(
                //     aspectRatio: controller1!.value.aspectRatio,
                //     child: VideoPlayer(controller1!),
                //     ),
                //   ),
                // ),
                //  GestureDetector(
                //    onTap: (){
                //      showDialog(
                //     context: context, 
                //     builder: (ctx) {
                //       return Text("${video2Height.toString()}, ${video2Width.toString()} ",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold));
                //     }
                //   );
                //    },
                //   child: Container(
                //     height: 0.5 * size.height,
                //     width: size.width,
                //     child: AspectRatio(
                //       aspectRatio: controller2!.value.aspectRatio,
                //       child: VideoPlayer(controller2!),
                //     ),
                //   ),
                //  ),
                GestureDetector(
                  onTap: (){
                    print("$video1Height");
                  },
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    height: video1Height,
                    width: video1Width,
                    child: AspectRatio(
                      aspectRatio: controller1!.value.aspectRatio,
                      child: VideoPlayer(controller1!),
                    ),
                  ),
                ),),
                GestureDetector(
                  onTap: (){
                    print("$video2Width");
                  },
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    height: video2Height,
                    width: video2Width,
                    child: AspectRatio(
                      aspectRatio: controller2!.value.aspectRatio,
                      child: VideoPlayer(controller2!),
                    ),
                  ),
                ),)
              ],
            )
          ],
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}