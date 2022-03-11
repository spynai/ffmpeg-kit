@JS()
library image_2_video.js;

import 'package:js/js.dart';

@JS()
@anonymous
external String convertImage2Video(String path);

@JS()
@anonymous
external String testMethod(String path);

@JS()
@anonymous
external String trimSelectedVideo(
    String name, String path, String start, String end);

@JS()
@anonymous
external String trimVideo(String path);

class Ffmpegkitweb {
  static image2Video(String toBeConvertedPath) {
    return convertImage2Video(toBeConvertedPath);
  }

  static trimTheVideo(String toBeTrimmedPath) {
    return trimVideo(toBeTrimmedPath);
  }

  static trimTheSelectedVideo(
      String filename, String toBeTrimmedPath, String start, String end) {
    return trimSelectedVideo(filename, toBeTrimmedPath, start, end);
  }

  static test(String path) {
    return testMethod(path);
  }
}
