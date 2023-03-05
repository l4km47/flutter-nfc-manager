import 'package:flutter/foundation.dart';
import 'package:nfc_manager/src/nfc_manager_android/nfc_manager.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.g.dart';

/// The class providing access to NFC-A (ISO 14443-3A) operations for Android.
///
/// Acquire an instance using [from(NfcTag)].
class NfcAAndroid {
  const NfcAAndroid._(
    this._handle, {
    required this.tag,
    required this.atqa,
    required this.sak,
  });

  final String _handle;

  final NfcTagAndroid tag;

  final Uint8List atqa;

  final int sak;

  /// Creates an instance of this class for the given tag.
  ///
  /// Returns null if the tag is not compatible.
  static NfcAAndroid? from(NfcTagAndroid tag) {
    // ignore: invalid_use_of_protected_member
    final pigeonTag = PigeonTag.decode(tag.data);
    final pigeon = pigeonTag.nfcA;
    return pigeon == null
        ? null
        : NfcAAndroid._(
            pigeonTag.handle!,
            tag: tag,
            atqa: pigeon.atqa!,
            sak: pigeon.sak!,
          );
  }

  Future<int> getMaxTransceiveLength() {
    return hostApi.nfcAGetMaxTransceiveLength(_handle);
  }

  Future<int> getTimeout() {
    return hostApi.nfcAGetTimeout(_handle);
  }

  Future<void> setTimeout(int timeout) {
    return hostApi.nfcASetTimeout(_handle, timeout);
  }

  Future<Uint8List> transceive(Uint8List bytes) {
    return hostApi.nfcATransceive(_handle, bytes);
  }
}
