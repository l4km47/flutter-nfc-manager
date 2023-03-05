import 'package:flutter/foundation.dart';
import 'package:nfc_manager/src/nfc_manager_android/nfc_manager.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.g.dart';

/// The class providing access to NFC-B (ISO 14443-3B) operations for Android.
///
/// Acquire an instance using [from(NfcTag)].
class NfcBAndroid {
  const NfcBAndroid._(
    this._handle, {
    required this.tag,
    required this.applicationData,
    required this.protocolInfo,
  });

  final String _handle;

  final NfcTagAndroid tag;

  final Uint8List applicationData;

  final Uint8List protocolInfo;

  /// Creates an instance of this class for the given tag.
  ///
  /// Returns null if the tag is not compatible.
  static NfcBAndroid? from(NfcTagAndroid tag) {
    // ignore: invalid_use_of_protected_member
    final pigeonTag = PigeonTag.decode(tag.data);
    final pigeon = pigeonTag.nfcB;
    return pigeon == null
        ? null
        : NfcBAndroid._(
            pigeonTag.handle!,
            tag: tag,
            applicationData: pigeon.applicationData!,
            protocolInfo: pigeon.protocolInfo!,
          );
  }

  Future<int> getMaxTransceiveLength() {
    return hostApi.nfcBGetMaxTransceiveLength(_handle);
  }

  Future<Uint8List> transceive(Uint8List bytes) {
    return hostApi.nfcBTransceive(_handle, bytes);
  }
}
