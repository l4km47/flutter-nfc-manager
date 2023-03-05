import 'package:flutter/foundation.dart';
import 'package:nfc_manager/src/nfc_manager_android/nfc_manager.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.g.dart';

/// The class providing access to MIFARE Ultralight operations for Android.
///
/// Acquire an instance using [from(NfcTag)].
class MifareUltralightAndroid {
  const MifareUltralightAndroid._(
    this._handle, {
    required this.tag,
    required this.type,
  });

  final String _handle;

  final NfcTagAndroid tag;

  final MifareUltralightTypeAndroid type;

  /// Creates an instance of this class for the given tag.
  ///
  /// Returns null if the tag is not compatible.
  static MifareUltralightAndroid? from(NfcTagAndroid tag) {
    // ignore: invalid_use_of_protected_member
    final pigeonTag = PigeonTag.decode(tag.data);
    final pigeon = pigeonTag.mifareUltralight;
    return pigeon == null
        ? null
        : MifareUltralightAndroid._(
            pigeonTag.handle!,
            tag: tag,
            type: mifareUltralightTypeFromPigeon(pigeon.type!),
          );
  }

  Future<int> getMaxTransceiveLength() {
    return hostApi.mifareUltralightGetMaxTransceiveLength(_handle);
  }

  Future<int> getTimeout() {
    return hostApi.mifareUltralightGetTimeout(_handle);
  }

  Future<void> setTimeout(int timeout) {
    return hostApi.mifareUltralightSetTimeout(_handle, timeout);
  }

  Future<Uint8List> readPages({
    required int pageOffset,
  }) {
    return hostApi.mifareUltralightReadPages(_handle, pageOffset);
  }

  Future<void> writePage({
    required int pageOffset,
    required Uint8List data,
  }) {
    return hostApi.mifareUltralightWritePage(_handle, pageOffset, data);
  }

  Future<Uint8List> transceive(Uint8List bytes) {
    return hostApi.mifareUltralightTransceive(_handle, bytes);
  }
}

enum MifareUltralightTypeAndroid {
  ultralight,
  ultralightC,
  unknown,
}
