import 'package:flutter/foundation.dart';
import 'package:nfc_manager/src/nfc_manager_android/nfc_manager.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.g.dart';

/// The class providing access to NFC-V (ISO 15693) operations for Android.
///
/// Acquire an instance using [from(NfcTag)].
class NfcVAndroid {
  const NfcVAndroid._(
    this._handle, {
    required this.tag,
    required this.dsfId,
    required this.responseFlags,
  });

  final String _handle;

  final NfcTagAndroid tag;

  final int dsfId;

  final int responseFlags;

  /// Creates an instance of this class for the given tag.
  ///
  /// Returns null if the tag is not compatible.
  static NfcVAndroid? from(NfcTagAndroid tag) {
    // ignore: invalid_use_of_protected_member
    final pigeonTag = PigeonTag.decode(tag.data);
    final pigeon = pigeonTag.nfcV;
    return pigeon == null
        ? null
        : NfcVAndroid._(
            pigeonTag.handle!,
            tag: tag,
            dsfId: pigeon.dsfId!,
            responseFlags: pigeon.responseFlags!,
          );
  }

  Future<int> getMaxTransceiveLength() {
    return hostApi.nfcVGetMaxTransceiveLength(_handle);
  }

  Future<Uint8List> transceive(Uint8List bytes) {
    return hostApi.nfcVTransceive(_handle, bytes);
  }
}
