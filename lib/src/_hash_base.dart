
part of dart_webcrypto;

abstract class _HashBase extends Hash {

  List<int> _data = [];

  void add(List<int> data) {
    _data.addAll(data);
  }

  Future<List<int>> close() {
    var crypto = _detectCryptoSubtle();

    if(crypto == null){
      C.Hash h = createCorrespondingNativeHash();
      h.add(_data);
      return new Future.value(h.close());
    } else {
      var d = new Uint8List.fromList(_data);
      return doHash(crypto, d);
    }
  }

  Future<List<int>> doHash(subtle, data);

  /// If the webcrypto api is not available, use the corresponding native hash implementation
  ///
  C.Hash createCorrespondingNativeHash();


  /// Detects the crypto subtle (including prefixes)
  JsObject _detectCryptoSubtle(){

    if(browser.isIe) return null;

    if(context["crypto"] == null){
      //No chance, no crypto support
      return null;
    } else if(context["crypto"]["subtle"] != null){
      return context["crypto"]["subtle"];
    } else if(context["crypto"]["webkitSubtle"] != null){
      return context["crypto"]["webkitSubtle"];
    }

    return null;

  }

  List<int> jsArrayToList(JsObject arrayBuffer){
    List<int> result = [];

    for(int i = 0; i<arrayBuffer['byteLength']; i++){
      result.add(arrayBuffer[i]);
    }
    return result;
  }

}
