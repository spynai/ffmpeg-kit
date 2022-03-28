// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:ffmpeg_kit_flutter_web/ffmpeg_kit_flutter_web.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

/// App for testing
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  testClicked() {
    var value = Ffmpegkitweb.test("test path");
    print("value of converted url ${value}");
  }

// [-i, path, -pix_fmt, yuv420p, -vf, split[original][copy];[copy]scale=ih*16/9:-1,crop=h=iw*9/16,gblur=sigma=25[blurred];[blurred][original]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2, path]
  testArgsClicked() {
    List<String> value = Ffmpegkitweb.parseArguments(
        "-i path -pix_fmt yuv420p -vf split[original][copy];[copy]scale=ih*16/9:-1,crop=h=iw*9/16,gblur=sigma=25[blurred];[blurred][original]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2 path");
    print("formatted args size and values");
    print(value.length);
    print(value.toString());
  }

  image2VideoClicked() {
    var value = Ffmpegkitweb.image2Video("path");
    print("value of converted url ${value}");
  }

  trimVideoClicked() {
    var value = Ffmpegkitweb.trimTheVideo("path");
    print("value of converted url ${value}");
  }


  final ImagePicker _picker = ImagePicker();

  void _pickImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      print("file selected");
      print("path ${file.path}");
      print("name ${file.name}");
      uploadToFirebase(file.path, file.name);
    }
  }

  uploadToFirebase(String path, String name) async {
    dynamic value = await DartToJsUpload.uploadToFirebase(path, name);
    var result = value as String;
    print("download url of the uploaded file ${result}");
  }

  void _pickVideo() async {
    final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);
    if (file != null) {
      print("file selected");
      print("path ${file.path}");
      print("name ${file.name}");
      //cropping and trimming
      // '-i', name, '-filter:v', 'crop=1319:972:420:31', '-ss', '5.11', '-to', '9.51', 'output.mp4'
      // dynamic value = await Ffmpegkitweb.executeAsync(
      //     file.name,
      //     file.path,
      //     '-filter:v crop=1319:972:420:31 -ss 5.11 -to 9.51 output.mp4',
      //     "output.mp4");
      // var result = value as String;
      // print("result from dart to main after crop and trim ${result}");

      //frame extraction
      // dynamic value = await Ffmpegkitweb.executeAsync(
      //     file.name, file.path, '-ss 2 -frames:v 1 output.mp4', "output.mp4");
      // var result = value as String;
      // print("result from dart to main after frame extraction ${result}");

      //gif
      dynamic value = await Ffmpegkitweb.executeAsync(file.name, file.path,
          '-vf fps=5,scale=320:-1:flags=lanczos output.gif', "output.gif");
      var result = value as String;
      print("result from dart to main after gif ${result}");

      //scalling, blurring
      // dynamic value1 = await Ffmpegkitweb.executeAsync(
      //     file.name,
      //     result,
      //     '-pix_fmt yuv420p -vf split[original][copy];[copy]scale=ih*16/9:-1,crop=h=iw*9/16,gblur=sigma=25[blurred];[blurred][original]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2 output.mp4',
      //     "output.mp4");
      // var result1 = value1 as String;
      // print("result from dart to main after scale and blur ${result1}");

      //trim
      // dynamic value = await Ffmpegkitweb.trimTheSelectedVideo(
      //     file.name, file.path, 0.toString(), 1.toString());
      // dynamic value =
      //     await Ffmpegkitweb.executeCropAndTrimTestAsync(file.name, file.path, "Hi");
      // var result = value as String;
      // print("result from dart to main after trim ${result}");

      //scale and blurr
      // dynamic value1 =
      //     await Ffmpegkitweb.executeScaleAndBlurTestAsync(file.name, result, "Hi");
      // var result1 = value1 as String;
      // print("result from dart to main after scale and blurr ${result1}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ElevatedButton(
              onPressed: () {
                testClicked();
              },
              child: Text("Test")),
          ElevatedButton(
              onPressed: () {
                testArgsClicked();
              },
              child: Text("Test Args")),
          ElevatedButton(
              onPressed: () {
                image2VideoClicked();
              },
              child: Text("From Asset Image to Video")),
          ElevatedButton(
              onPressed: () {
                trimVideoClicked();
              },
              child: Text("From Asset Trim Video")),
          ElevatedButton(
              onPressed: () {
                _pickVideo();
              },
              child: Text("From Local Trim Video")),
          ElevatedButton(
              onPressed: () {
                _pickImage();
              },
              child: Text("Pick And Upload To Firebase"))
        ]),
      ),
    );
  }
}
