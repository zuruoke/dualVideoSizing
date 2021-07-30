import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reminisce/video_player.dart';
import 'package:reminisce/view/trimmer_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Reminisce Video App'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final ImagePicker picker = ImagePicker();
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  handleDoubleUploadVideoFromGallery(BuildContext context) async {
    final Size size = MediaQuery.of(context).size;
    print(size.height);
    print(size.width);
    final XFile? videoFile1 = await picker.pickVideo(source: ImageSource.gallery, maxDuration: Duration(seconds: 30));
    final XFile? videoFile2 = await picker.pickVideo(source: ImageSource.gallery, maxDuration: Duration(seconds: 30));
    if (videoFile1 != null  && videoFile2 != null){
      final File video_1 = File(videoFile1.path);
      final File video_2 = File(videoFile2.path);
    //   Navigator.push(context, MaterialPageRoute(
    //     builder: (ctx) => VideoPlayerScreen( 
    //       video1: video1,
    //       video2: video2,
    //       screenHeight: size.height,
    //       screenWidth: size.width
    // )));
    Navigator.push(context, 
      MaterialPageRoute(
      builder: (_) => TrimmerView(
        video1: video_1, video2: video_2)
      ));
    }
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: TextButton(
          onPressed: (){
            handleDoubleUploadVideoFromGallery(context);
          }, 
          child: Text('Upload', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )
          ),
        )
      ),
    );
  }
}
