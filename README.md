# dart-webcrypto
This is a wrapper library to easily make the webcrypto capabilities available in Dart. 
Currently only hash functions available, where also a native Dart implementation is available.

If the selected browser does not support [webcrypto API](http://www.w3.org/TR/WebCryptoAPI/) the library falls back to native Dart implementations.

Unfortunetaly the promise based webcrypto interface is not compatible with the synchronous native Hash interface.

```dart
var h = new SHA1();
h.add(UTF8.encode("hashme"));
h.close().then((List<int> digest){
    print(CryptoUtils.bytesToHex(digest));
});
```