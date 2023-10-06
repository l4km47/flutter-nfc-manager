import 'package:ndef_record/ndef_record.dart';
import 'package:nfc_manager/src/nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/src/nfc_manager_ios/pigeon.dart';
import 'package:nfc_manager/src/nfc_manager_ios/pigeon.g.dart';

/// The class providing access to NDEF operations for iOS.
///
/// Acquire an instance using [from(NfcTag)].
class NdefIOS {
  NdefIOS._(
    this._handle, {
    required this.status,
    required this.capacity,
    required this.cachedNdefMessage,
  });

  final String _handle;

  final NdefStatusIOS status;

  final int capacity;

  final NdefMessage? cachedNdefMessage;

  /// Creates an instance of this class for the given tag.
  ///
  /// Returns null if the tag is not compatible.
  static NdefIOS? from(NfcTag tag) {
    // ignore: invalid_use_of_protected_member
    final pigeonTag = PigeonTag.decode(tag.data);
    final pigeon = pigeonTag.ndef;
    return pigeon == null
        ? null
        : NdefIOS._(
            pigeonTag.handle!,
            status: ndefStatusFromPigeon(pigeon.status!),
            capacity: pigeon.capacity!,
            cachedNdefMessage: pigeon.cachedNdefMessage == null
                ? null
                : NdefMessage(
                    records: pigeon.cachedNdefMessage!.records
                            ?.map((r) => NdefRecord(
                                  typeNameFormat: typeNameFormatFromPigeon(
                                      r!.typeNameFormat!),
                                  type: r.type!,
                                  identifier: r.identifier!,
                                  payload: r.payload!,
                                ))
                            .toList() ??
                        [],
                  ),
          );
  }

  Future<QueryNdefStatusResponseIOS> queryNdefStatus() {
    return hostApi
        .ndefQueryNDEFStatus(_handle)
        .then((value) => QueryNdefStatusResponseIOS(
              status: ndefStatusFromPigeon(value.status!),
              capacity: value.capacity!,
            ));
  }

  Future<NdefMessage?> readNdef() {
    return hostApi.ndefReadNDEF(_handle).then((value) => value == null
        ? null
        : NdefMessage(
            records: value.records
                    ?.map((r) => NdefRecord(
                          typeNameFormat:
                              typeNameFormatFromPigeon(r!.typeNameFormat!),
                          type: r.type!,
                          identifier: r.identifier!,
                          payload: r.payload!,
                        ))
                    .toList() ??
                [],
          ));
  }

  Future<void> writeNdef(NdefMessage message) {
    return hostApi.ndefWriteNDEF(
        _handle,
        PigeonNdefMessage(
          records: message.records
              .map((e) => PigeonNdefPayload(
                    typeNameFormat: typeNameFormatToPigeon(e.typeNameFormat),
                    type: e.type,
                    identifier: e.identifier,
                    payload: e.payload,
                  ))
              .toList(),
        ));
  }

  Future<void> writeLock() {
    return hostApi.ndefWriteLock(_handle);
  }
}

class QueryNdefStatusResponseIOS {
  const QueryNdefStatusResponseIOS(
      {required this.status, required this.capacity});

  final NdefStatusIOS status;

  final int capacity;
}

enum NdefStatusIOS {
  notSupported,

  readOnly,

  readWrite,
}
