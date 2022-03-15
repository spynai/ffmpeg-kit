// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:ffmpeg_kit_flutter_web/ffmpegkitweb.dart';
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
      dynamic value = await Ffmpegkitweb.trimTheSelectedVideo(
          file.name, file.path, 0.toString(), 1.toString());
      print("result from dart to main");
      var result = value as String;
      print("converted url ${result}");
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
