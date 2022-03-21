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
    print(value);
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

  void _pickVideo() async {
    final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);
    if (file != null) {
      print("file selected");
      print("path ${file.path}");
      print("name ${file.name}");
      print("file selected");
      // dynamic value = await Ffmpegkitweb.trimTheSelectedVideo(
      //     file.name, file.path, 0.toString(), 1.toString());
      dynamic value =
          await Ffmpegkitweb.executeAsync(file.name, file.path, "Hi");
      var result = value as String;
      print("result from dart to main ${result}");
      dynamic value1 =
          await Ffmpegkitweb.executeAsync1(file.name, result, "Hi");
      var result1 = value1 as String;
      print("result from dart to main ${result1}");
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
              child: Text("From Local Trim Video"))
        ]),
      ),
    );
  }
}
