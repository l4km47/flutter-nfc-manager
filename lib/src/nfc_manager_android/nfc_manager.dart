import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:nfc_manager/src/nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.g.dart';

/// The entry point for accessing the NFC features on Android.
class NfcManagerAndroid {
  NfcManagerAndroid._() {
    _flutterApi = _NfcManagerAndroidFlutterApi(this);
  }

  /// The instance of the [NfcManagerAndroid] to use.
  static NfcManagerAndroid _instance = NfcManagerAndroid._();
  static NfcManagerAndroid get instance => _instance;

  // ignore: unused_field
  PigeonFlutterApi? _flutterApi;

  // ignore: close_sinks
  final StreamController<int> _onAdapterStateChanged =
      StreamController<int>.broadcast();
  Stream<int> get onAdapterStateChanged => _onAdapterStateChanged.stream;

  void Function(NfcTagAndroid)? _onTagDiscovered;

  /// TODO: DOC
  Future<bool> isEnabled() {
    return hostApi.nfcAdapterIsEnabled();
  }

  /// TODO: DOC
  Future<bool> isSecureNfcEnabled() {
    return hostApi.nfcAdapterIsSecureNfcEnabled();
  }

  /// TODO: DOC
  Future<bool> isSecureNfcSupported() {
    return hostApi.nfcAdapterIsSecureNfcSupported();
  }

  /// TODO: DOC
  Future<void> enableReaderMode({
    required Set<NfcReaderFlagAndroid> flags,
    required void Function(NfcTagAndroid) onTagDiscovered,
  }) {
    _onTagDiscovered = onTagDiscovered;
    return hostApi
        .nfcAdapterEnableReaderMode(flags.map((e) => e.name).toList());
  }

  /// TODO: DOC
  Future<void> disableReaderMode() {
    _onTagDiscovered = null;
    return hostApi.nfcAdapterDisableReaderMode();
  }

  /// TODO: DOC
  Future<void> enableForegroundDispatch() {
    return hostApi.nfcAdapterEnableForegroundDispatch();
  }

  /// TODO: DOC
  Future<void> disableForegroundDispatch() {
    return hostApi.nfcAdapterDisableForegroundDispatch();
  }
}

class _NfcManagerAndroidFlutterApi implements PigeonFlutterApi {
  _NfcManagerAndroidFlutterApi(this._instance) {
    PigeonFlutterApi.setup(this);
  }

  final NfcManagerAndroid _instance;

  @override
  void onAdapterStateChanged(int state) {
    _instance._onAdapterStateChanged.sink.add(state);
  }

  @override
  void onTagDiscovered(PigeonTag tag) {
    final nfcTag = NfcTagAndroid(
        id: tag.id!, techList: tag.techList!.cast(), data: tag.encode());
    _instance._onTagDiscovered?.call(nfcTag);
  }
}

/// TODO: DOC
class NfcTagAndroid implements NfcTag {
  /// TODO: DOC
  @visibleForTesting
  const NfcTagAndroid(
      {required this.id, required this.techList, required this.data});

  /// TODO: DOC
  final Uint8List id;

  /// TODO: DOC
  final List<String> techList;

  /// TODO: DOC
  @protected
  final Object data;
}

/// TODO: DOC
enum NfcReaderFlagAndroid {
  nfcA,
  nfcB,
  nfcBarcode,
  nfcF,
  nfcV,
  noPlatformSounds,
  skipNdefCheck,
}
