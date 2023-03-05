import 'package:ndef_record/ndef_record.dart';
import 'package:nfc_manager/src/nfc_manager_android/nfc_manager.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.g.dart';

/// The class providing access to NDEF format operations for Android.
///
/// Acquire an instance using [from(NfcTag)].
class NdefFormatableAndroid {
  const NdefFormatableAndroid._(this._handle, {required this.tag});

  final String _handle;

  final NfcTagAndroid tag;

  /// Creates an instance of this class for the given tag.
  ///
  /// Returns null if the tag is not compatible.
  static NdefFormatableAndroid? from(NfcTagAndroid tag) {
    // ignore: invalid_use_of_protected_member
    final pigeonTag = PigeonTag.decode(tag.data);
    final pigeon = pigeonTag.ndefFormatable;
    return pigeon == null
        ? null
        : NdefFormatableAndroid._(pigeonTag.handle!, tag: tag);
  }

  Future<void> format(NdefMessage firstMessage) {
    return hostApi.ndefFormatableFormat(
        _handle,
        PigeonNdefMessage(
          records: firstMessage.records
              .map((e) => PigeonNdefRecord(
                    tnf: typeNameFormatToPigeon(e.typeNameFormat),
                    type: e.type,
                    id: e.identifier,
                    payload: e.payload,
                  ))
              .toList(),
        ));
  }

  Future<void> formatReadOnly(NdefMessage firstMessage) {
    return hostApi.ndefFormatableFormatReadOnly(
        _handle,
        PigeonNdefMessage(
          records: firstMessage.records
              .map((e) => PigeonNdefRecord(
                    tnf: typeNameFormatToPigeon(e.typeNameFormat),
                    type: e.type,
                    id: e.identifier,
                    payload: e.payload,
                  ))
              .toList(),
        ));
  }
}
