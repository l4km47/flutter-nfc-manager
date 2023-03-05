import 'dart:typed_data';

import 'package:nfc_manager/src/nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/src/nfc_manager_ios/pigeon.dart';
import 'package:nfc_manager/src/nfc_manager_ios/pigeon.g.dart';

/// The entry point for accessing the NFC features on iOS.
class NfcManagerIOS {
  NfcManagerIOS._() {
    _flutterApi = _NfcManagerIOSFlutterApi(this);
  }

  /// The instance of the [NfcManagerIOS] to use.
  static NfcManagerIOS _instance = NfcManagerIOS._();
  static NfcManagerIOS get instance => _instance;

  // ignore: unused_field
  PigeonFlutterApi? _flutterApi;

  void Function(NfcTag)? _tagReaderSessionDidDetectTag;
  void Function()? _tagReaderSessionDidBecomeActive;
  void Function(NfcReaderSessionErrorIOS)?
      _tagReaderSessionDidInvalidateWithError;
  void Function(List<NfcVasResponseIOS>)? _vasReaderSessionDidReceive;
  void Function()? _vasReaderSessionDidBecomeActive;
  void Function(NfcReaderSessionErrorIOS)?
      _vasReaderSessionDidInvalidateWithError;

  /// TODO: DOC
  Future<bool> tagReaderSessionReadingAvailable() {
    return hostApi.tagReaderSessionReadingAvailable();
  }

  /// TODO: DOC
  Future<void> tagReaderSessionBegin({
    required Set<NfcPollingOption> pollingOptions,
    required void Function(NfcTag)? didDetectTag,
    void Function()? didBecomeActive,
    void Function(NfcReaderSessionErrorIOS)? didInvalidateWithError,
    String? alertMessage,
    bool invalidateAfterFirstRead = true,
  }) {
    _tagReaderSessionDidDetectTag = didDetectTag;
    _tagReaderSessionDidBecomeActive = didBecomeActive;
    _tagReaderSessionDidInvalidateWithError = didInvalidateWithError;
    return hostApi.tagReaderSessionBegin(
      pollingOptions.map((e) => e.name).toList(),
      alertMessage,
      invalidateAfterFirstRead,
    );
  }

  /// TODO: DOC
  Future<void> tagReaderSessionInvalidate({
    String? alertMessage,
    String? errorMessage,
  }) {
    _tagReaderSessionDidDetectTag = null;
    _tagReaderSessionDidBecomeActive = null;
    _tagReaderSessionDidInvalidateWithError = null;
    return hostApi.tagReaderSessionInvalidate(alertMessage, errorMessage);
  }

  /// TODO: DOC
  Future<void> tagReaderSessionSetAlertMessage({required String alertMessage}) {
    return hostApi.tagReaderSessionSetAlertMessage(alertMessage);
  }

  /// TODO: DOC
  Future<void> tagReaderSessionRestartPolling() {
    return hostApi.tagReaderSessionRestartPolling();
  }

  /// TODO: DOC
  Future<void> vasReaderSessionBegin({
    required List<NfcVasCommandConfigurationIOS> configurations,
    required void Function(List<NfcVasResponseIOS> configurations) didReceive,
    void Function()? didBecomeActive,
    void Function(NfcReaderSessionErrorIOS error)? didInvalidateWithError,
    String? alertMessage,
  }) {
    _vasReaderSessionDidBecomeActive = didBecomeActive;
    _vasReaderSessionDidInvalidateWithError = didInvalidateWithError;
    _vasReaderSessionDidReceive = didReceive;
    return hostApi.vasReaderSessionBegin(
        configurations
            .map((e) => PigeonNfcVasCommandConfiguration(
                  mode: vasCommandConfigurationModeToPigeon(e.vasMode),
                  passIdentifier: e.passIdentifier,
                  url: e.url?.toString(),
                ))
            .toList(),
        alertMessage);
  }

  /// TODO: DOC
  Future<void> vasReaderSessionInvalidate(
      {String? alertMessage, String? errorMessage}) {
    _vasReaderSessionDidBecomeActive = null;
    _vasReaderSessionDidInvalidateWithError = null;
    _vasReaderSessionDidReceive = null;
    return hostApi.vasReaderSessionInvalidate(alertMessage, errorMessage);
  }

  /// TODO: DOC
  Future<void> vasReaderSessionSetAlertMessage({required String alertMessage}) {
    return hostApi.vasReaderSessionSetAlertMessage(alertMessage);
  }
}

class _NfcManagerIOSFlutterApi implements PigeonFlutterApi {
  _NfcManagerIOSFlutterApi(this._instance) {
    PigeonFlutterApi.setup(this);
  }

  final NfcManagerIOS _instance;

  @override
  void tagReaderSessionDidBecomeActive() {
    _instance._tagReaderSessionDidBecomeActive?.call();
  }

  @override
  void tagReaderSessionDidInvalidateWithError(
      PigeonNfcReaderSessionError error) {
    final nfcError = NfcReaderSessionErrorIOS(
      code: readerErrorCodeFromPigeon(error.code!),
      message: error.message!,
    );
    _instance._tagReaderSessionDidInvalidateWithError?.call(nfcError);
  }

  @override
  void tagReaderSessionDidDetect(PigeonTag tag) {
    // ignore: invalid_use_of_visible_for_testing_member
    final nfcTag = NfcTag(data: tag.encode());
    _instance._tagReaderSessionDidDetectTag?.call(nfcTag);
  }

  @override
  void vasReaderSessionDidBecomeActive() {
    _instance._vasReaderSessionDidBecomeActive?.call();
  }

  @override
  void vasReaderSessionDidInvalidateWithError(
      PigeonNfcReaderSessionError error) {
    final nfcError = NfcReaderSessionErrorIOS(
      code: readerErrorCodeFromPigeon(error.code!),
      message: error.message!,
    );
    _instance._vasReaderSessionDidInvalidateWithError?.call(nfcError);
  }

  @override
  void vasReaderSessionDidReceive(List<PigeonNfcVasResponse?> responses) {
    _instance._vasReaderSessionDidReceive?.call(responses
        .map((e) => NfcVasResponseIOS(
              status: vasResponseErrorCodeFromPigeon(e!.status!),
              vasData: e.vasData!,
              mobileToken: e.mobileToken!,
            ))
        .toList());
  }
}

/// TODO: DOC
class NfcVasCommandConfigurationIOS {
  /// TODO: DOC
  NfcVasCommandConfigurationIOS(
      {required this.vasMode, required this.passIdentifier, this.url});

  /// TODO: DOC
  final NfcVasCommandConfigurationModeIOS vasMode;

  /// TODO: DOC
  final String passIdentifier;

  /// TODO: DOC
  final Uri? url;
}

/// TODO: DOC
class NfcVasResponseIOS {
  /// TODO: DOC
  NfcVasResponseIOS(
      {required this.status, required this.vasData, required this.mobileToken});

  /// TODO: DOC
  final NfcVasResponseErrorCodeIOS status;

  /// TODO: DOC
  final Uint8List vasData;

  /// TODO: DOC
  final Uint8List mobileToken;
}

/// TODO: DOC
class NfcReaderSessionErrorIOS {
  /// TODO: DOC
  const NfcReaderSessionErrorIOS({required this.code, required this.message});

  /// TODO: DOC
  final NfcReaderErrorCodeIOS code;

  /// TODO: DOC
  final String message;
}

/// TODO: DOC
enum NfcVasCommandConfigurationModeIOS {
  /// TODO: DOC
  normal,

  /// TODO: DOC
  urlOnly,
}

/// TODO: DOC
enum NfcReaderErrorCodeIOS {
  /// TODO: DOC
  readerSessionInvalidationErrorFirstNDEFTagRead,

  /// TODO: DOC
  readerSessionInvalidationErrorSessionTerminatedUnexpectedly,

  /// TODO: DOC
  readerSessionInvalidationErrorSessionTimeout,

  /// TODO: DOC
  readerSessionInvalidationErrorSystemIsBusy,

  /// TODO: DOC
  readerSessionInvalidationErrorUserCanceled,

  /// TODO: DOC
  ndefReaderSessionErrorTagNotWritable,

  /// TODO: DOC
  ndefReaderSessionErrorTagSizeTooSmall,

  /// TODO: DOC
  ndefReaderSessionErrorTagUpdateFailure,

  /// TODO: DOC
  ndefReaderSessionErrorZeroLengthMessage,

  /// TODO: DOC
  readerTransceiveErrorRetryExceeded,

  /// TODO: DOC
  readerTransceiveErrorTagConnectionLost,

  /// TODO: DOC
  readerTransceiveErrorTagNotConnected,

  /// TODO: DOC
  readerTransceiveErrorTagResponseError,

  /// TODO: DOC
  readerTransceiveErrorSessionInvalidated,

  /// TODO: DOC
  readerTransceiveErrorPacketTooLong,

  /// TODO: DOC
  tagCommandConfigurationErrorInvalidParameters,

  /// TODO: DOC
  readerErrorUnsupportedFeature,

  /// TODO: DOC
  readerErrorInvalidParameter,

  /// TODO: DOC
  readerErrorInvalidParameterLength,

  /// TODO: DOC
  readerErrorParameterOutOfBound,

  /// TODO: DOC
  readerErrorRadioDisabled,

  /// TODO: DOC
  readerErrorSecurityViolation,

  /// TODO: DOC
  unknown,
}

/// TODO: DOC
enum NfcVasResponseErrorCodeIOS {
  /// TODO: DOC
  success,

  /// TODO: DOC
  userIntervention,

  /// TODO: DOC
  dataNotActivated,

  /// TODO: DOC
  dataNotFound,

  /// TODO: DOC
  incorrectData,

  /// TODO: DOC
  unsupportedApplicationVersion,

  /// TODO: DOC
  wrongLCField,

  /// TODO: DOC
  wrongParameters,
}
