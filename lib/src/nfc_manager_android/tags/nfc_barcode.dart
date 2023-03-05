import 'package:flutter/foundation.dart';
import 'package:nfc_manager/src/nfc_manager_android/nfc_manager.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.g.dart';

/// The class providing access to tags containing just a barcode for Android.
///
/// Acquire an instance using [from(NfcTag)].
class NfcBarcodeAndroid {
  const NfcBarcodeAndroid._(
    this._handle, {
    required this.tag,
    required this.type,
    required this.barcode,
  });

  // ignore: unused_field
  final String _handle;

  final NfcTagAndroid tag;

  final int type;

  final Uint8List barcode;

  /// Creates an instance of this class for the given tag.
  ///
  /// Returns null if the tag is not compatible.
  static NfcBarcodeAndroid? from(NfcTagAndroid tag) {
    // ignore: invalid_use_of_protected_member
    final pigeonTag = PigeonTag.decode(tag.data);
    final pigeon = pigeonTag.nfcBarcode;
    return pigeon == null
        ? null
        : NfcBarcodeAndroid._(
            pigeonTag.handle!,
            tag: tag,
            type: pigeon.type!,
            barcode: pigeon.barcode!,
          );
  }
}
