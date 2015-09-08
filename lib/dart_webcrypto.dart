library dart_webcrypto;


import "dart:html";
import "dart:js";
import "dart:async";
import "dart:typed_data" show Uint8List;

import "package:crypto/crypto.dart" as C;
import "package:browser_detect/browser_detect.dart";
import "package:dart_webcrypto/dart_webcrypto.dart";

part 'src/_hash_base.dart';
part 'src/sha1.dart';
part 'src/sha256.dart';

abstract class Hash {
  /**
   * Add a list of bytes to the hash computation.
   */
  void add(List<int> data);

  /**
   * Finish the hash computation and extract the message digest as
   * a list of bytes.
   */
  Future<List<int>> close();

  /**
   * Returns a new instance of this hash function.
   */
  Hash newInstance();
}