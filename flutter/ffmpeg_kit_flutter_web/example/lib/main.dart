// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:ffmpeg_kit_flutter_web/ffmpegkitweb.dart';
import 'package:flutter/material.dart';

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
              child: Text("Image to Video")),
          ElevatedButton(
              onPressed: () {
                trimVideoClicked();
              },
              child: Text("Trim Video"))
        ]),
      ),
    );
  }
}
