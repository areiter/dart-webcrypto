part of dart_webcrypto;

class SHA256 extends _HashBase {

  Future<List<int>> doHash(subtle, data) {
    Completer c = new Completer();

    var digestResult = subtle.callMethod('digest',["SHA-256", data]);
    digestResult.callMethod('then', [((digest){
      digest = new JsObject(context['Uint8Array'], [digest]);
      digest = jsArrayToList(digest);
      c.complete(digest);
    })]);

    digestResult.callMethod('catch', [((error){
      c.completeError(error);
    })]);

    return c.future;
  }

  C.Hash createCorrespondingNativeHash() {
    return new C.SHA256();
  }

  Hash newInstance() {
    return new SHA256();
  }


}