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
  onLoadClicked() {
   var value= Ffmpegkitweb.test("Hi");
   print("value of converted url ${value}");
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: ElevatedButton(
            onPressed: () {
              onLoadClicked();
            },
            child: Text("Load")),
      ),
    );
  }
}
