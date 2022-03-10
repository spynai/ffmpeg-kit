@JS()
library stringify;

import 'package:ffmpeg_kit_flutter_platform_interface/ffmpeg_kit_flutter_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js.dart';
import 'dart:html' as html;

class FFmpegKitFlutterPlugin extends FFmpegKitPlatform {
  /// Registers this class as the default instance of [FFmpegKitPlatform].
  static void registerWith(Registrar? registrar) {
    FFmpegKitPlatform.instance = FFmpegKitFlutterPlugin();
    print("register web");
    // html.document.head!.append(html.ScriptElement()
    //   ..src =
    //       'build/flutter_assets/packages/ffmpeg_kit_flutter_web/web/@ffmpeg/core/dist/ffmpeg-core.js' // ignore: unsafe_html
    //   ..type = 'application/javascript'
    //   ..defer = true);
    // html.document.head!.append(html.ScriptElement()
    //   ..src =
    //       'build/flutter_assets/packages/ffmpeg_kit_flutter_web/web/@ffmpeg/ffmpeg/dist/ffmpeg.min.js' // ignore: unsafe_html
    //   ..type = 'application/javascript'
    //   ..defer = true);
    // html.document.head!.append(html.ScriptElement()
    //   ..src =
    //       'build/flutter_assets/packages/ffmpeg_kit_flutter_web/web/require.js' // ignore: unsafe_html
    //   ..type = 'application/javascript'
    //   ..defer = true);
    html.document.head!.append(html.ScriptElement()
      ..src =
          'build/flutter_assets/packages/ffmpeg_kit_flutter_web/web/image_2_video.js' // ignore: unsafe_html
      ..type = 'text/javascript'
      ..defer = true);
  }

  void excecuteFilePath(String filePath, String params) {}
}
