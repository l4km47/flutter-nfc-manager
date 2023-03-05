import 'package:flutter/foundation.dart';
import 'package:nfc_manager/src/nfc_manager_android/nfc_manager.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.g.dart';

/// The class providing access to MIFARE Classic operations for Android.
///
/// Acquire an instance using [from(NfcTag)].
class MifareClassicAndroid {
  const MifareClassicAndroid._(
    this._handle, {
    required this.tag,
    required this.type,
    required this.blockCount,
    required this.sectorCount,
    required this.size,
  });

  final String _handle;

  final NfcTagAndroid tag;

  final MifareClassicTypeAndroid type;

  final int blockCount;

  final int sectorCount;

  final int size;

  /// Creates an instance of this class for the given tag.
  ///
  /// Returns null if the tag is not compatible.
  static MifareClassicAndroid? from(NfcTagAndroid tag) {
    // ignore: invalid_use_of_protected_member
    final pigeonTag = PigeonTag.decode(tag.data);
    final pigeon = pigeonTag.mifareClassic;
    return pigeon == null
        ? null
        : MifareClassicAndroid._(
            pigeonTag.handle!,
            tag: tag,
            type: mifareClassicTypeFromPigeon(pigeon.type!),
            blockCount: pigeon.blockCount!,
            sectorCount: pigeon.sectorCount!,
            size: pigeon.size!,
          );
  }

  Future<bool> authenticateSectorWithKeyA({
    required int sectorIndex,
    required Uint8List key,
  }) {
    return hostApi.mifareClassicAuthenticateSectorWithKeyA(
        _handle, sectorIndex, key);
  }

  Future<bool> authenticateSectorWithKeyB({
    required int sectorIndex,
    required Uint8List key,
  }) {
    return hostApi.mifareClassicAuthenticateSectorWithKeyB(
        _handle, sectorIndex, key);
  }

  Future<void> increment({
    required int blockIndex,
    required int value,
  }) {
    return hostApi.mifareClassicIncrement(_handle, blockIndex, value);
  }

  Future<void> decrement({
    required int blockIndex,
    required int value,
  }) {
    return hostApi.mifareClassicDecrement(_handle, blockIndex, value);
  }

  Future<Uint8List> readBlock({
    required int blockIndex,
  }) {
    return hostApi.mifareClassicReadBlock(_handle, blockIndex);
  }

  Future<void> writeBlock({
    required int blockIndex,
    required Uint8List data,
  }) {
    return hostApi.mifareClassicWriteBlock(_handle, blockIndex, data);
  }

  Future<void> restore({
    required int blockIndex,
  }) {
    return hostApi.mifareClassicRestore(_handle, blockIndex);
  }

  Future<void> transfer({
    required int blockIndex,
  }) {
    return hostApi.mifareClassicTransfer(_handle, blockIndex);
  }

  Future<Uint8List> transceive(Uint8List bytes) {
    return hostApi.mifareClassicTransceive(_handle, bytes);
  }
}

enum MifareClassicTypeAndroid {
  classic,
  plus,
  pro,
  unknown,
}
