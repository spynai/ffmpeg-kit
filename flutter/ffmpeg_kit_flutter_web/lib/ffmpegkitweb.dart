@JS()
library image_2_video.js;

import 'package:js/js.dart';
import 'dart:js_util';

@JS()
@anonymous
external String convertImage2Video(String path);

@JS()
@anonymous
external String testMethod(String path);

@JS()
@anonymous
external Future<String> trimSelectedVideo(
    String name, String path, String start, String end);

@JS()
@anonymous
external String trimVideo(String path);

class Ffmpegkitweb {
  static Future<String> image2Video(String toBeConvertedPath) async {
    return await convertImage2Video(toBeConvertedPath);
  }

  static Future<String> trimTheVideo(String toBeTrimmedPath) async {
    return await trimVideo(toBeTrimmedPath);
  }

  static Future trimTheSelectedVideo(
      String filename, String toBeTrimmedPath, String start, String end) async {
    var result = await promiseToFuture(
        trimSelectedVideo(filename, toBeTrimmedPath, start, end));
    print("result from js");
    print(result);
    return result;
  }

  static Future<String> test(String path) async {
    return await testMethod(path);
  }
}
