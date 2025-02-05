@JS()
library upload_firebase.js;

import 'package:js/js.dart';
import 'package:ffmpeg_kit_flutter_web/src/shims/dart_js_util.dart' as util;

@JS()
@anonymous
external Future<String> upload(
    String blobUrl, String filename, String contentType);

@JS()
@anonymous
external Future<String> getBlobFromFileUrl(String blobUrl);

class DartToJsUpload {
  static Future uploadToFirebase(
      String path, String filename, String contentType) async {
    var result =
        await util.JsUtil.promiseToFuture(upload(path, filename, contentType));
    print("result from js");
    print(result);
    return result;
  }

  static Future getBlob(String path) async {
    var result = await util.JsUtil.promiseToFuture(getBlobFromFileUrl(path));
    print("result from js");
    print(result);
    return result;
  }
}
