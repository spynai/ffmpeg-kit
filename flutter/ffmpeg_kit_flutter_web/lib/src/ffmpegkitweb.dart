@JS()
library image_2_video.js;

import 'package:js/js.dart';
import 'package:ffmpeg_kit_flutter_web/src/shims/dart_js_util.dart' as util;

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
external Future<String> execute(String name, String path, String command);

@JS()
@anonymous
external Future<String> execute1(String name, String path, String command);

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
    var result = await util.JsUtil.promiseToFuture(
        trimSelectedVideo(filename, toBeTrimmedPath, start, end));
    print("result from js");
    print(result);
    return result;
  }

  static Future executeAsync(
      String filename, String toBeExecutedPath, String command) async {
    var result = await util.JsUtil.promiseToFuture(
        execute(filename, toBeExecutedPath, command));
    print("result from js");
    print(result);
    return result;
  }

  static Future executeAsync1(
      String filename, String toBeExecutedPath, String command) async {
    var result = await util.JsUtil.promiseToFuture(
        execute1(filename, toBeExecutedPath, command));
    print("result from js");
    print(result);
    return result;
  }

  static Future<String> test(String path) async {
    return await testMethod(path);
  }

  /// Parses [command] into arguments. Uses space character to split the
  /// arguments. Supports single and double quote characters.
  static List<String> parseArguments(String command) {
    final List<String> argumentList = List<String>.empty(growable: true);
    StringBuffer currentArgument = new StringBuffer();

    bool singleQuoteStarted = false;
    bool doubleQuoteStarted = false;

    for (int i = 0; i < command.length; i++) {
      int? previousChar;
      if (i > 0) {
        previousChar = command.codeUnitAt(i - 1);
      } else {
        previousChar = null;
      }
      final currentChar = command.codeUnitAt(i);

      if (currentChar == ' '.codeUnitAt(0)) {
        if (singleQuoteStarted || doubleQuoteStarted) {
          currentArgument.write(String.fromCharCode(currentChar));
        } else if (currentArgument.length > 0) {
          argumentList.add(currentArgument.toString());
          currentArgument = new StringBuffer();
        }
      } else if (currentChar == '\''.codeUnitAt(0) &&
          (previousChar == null || previousChar != '\\'.codeUnitAt(0))) {
        if (singleQuoteStarted) {
          singleQuoteStarted = false;
        } else if (doubleQuoteStarted) {
          currentArgument.write(String.fromCharCode(currentChar));
        } else {
          singleQuoteStarted = true;
        }
      } else if (currentChar == '\"'.codeUnitAt(0) &&
          (previousChar == null || previousChar != '\\'.codeUnitAt(0))) {
        if (doubleQuoteStarted) {
          doubleQuoteStarted = false;
        } else if (singleQuoteStarted) {
          currentArgument.write(String.fromCharCode(currentChar));
        } else {
          doubleQuoteStarted = true;
        }
      } else {
        currentArgument.write(String.fromCharCode(currentChar));
      }
    }

    if (currentArgument.length > 0) {
      argumentList.add(currentArgument.toString());
    }

    return argumentList;
  }
}
