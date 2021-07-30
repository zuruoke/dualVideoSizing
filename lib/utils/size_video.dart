Map<String, dynamic> sizeVideo({
  required double videoHeight, 
  required double videoWidth,
  required double screenHeight,
  required double screenWidth,
  }){
  double? finalVideoHeight;
  double? finalVideoWidth;
  double initialVideoHeight = videoHeight;
  double initialVideoWidth = videoWidth;
  Map<String, dynamic> videoParam = {};
  int i = 0;
  if (initialVideoHeight > 0.5 * screenHeight || initialVideoWidth > screenWidth)
  while(initialVideoHeight > 0.5 * screenHeight || initialVideoWidth > screenWidth){
    if (i == 0){
    initialVideoHeight = initialVideoHeight / 1.5;
    initialVideoWidth = initialVideoWidth / 1.5;
    }
    else {
    initialVideoHeight = initialVideoHeight / 1.2;
    initialVideoWidth = initialVideoWidth / 1.2;
    }
    i += 1;
  }
  print(i);
  finalVideoHeight = initialVideoHeight;
  finalVideoWidth = initialVideoWidth;
  videoParam['height'] = finalVideoHeight;
  videoParam['width'] = finalVideoWidth;
  return videoParam;
  }