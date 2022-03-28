@JS()
library upload_firebase.js;

import 'package:js/js.dart';
import 'package:ffmpeg_kit_flutter_web/src/shims/dart_js_util.dart' as util;

@JS()
@anonymous
external Future<String> upload(String blobUrl, String filename);

@JS()
@anonymous
external Future<String> getFileBlobFromUrl(String blobUrl);

class DartToJsUpload {
  static Future uploadToFirebase(String path, String filename) async {
    // var result = await util.JsUtil.promiseToFuture(upload(path, filename));
    var result = await util.JsUtil.promiseToFuture(getFileBlobFromUrl(path));
    print("result from js");
    print(result);
    return result;
  }
}
