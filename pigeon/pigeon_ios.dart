import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  swiftOut: 'ios/Classes/Pigeon.swift',
  dartOut: 'lib/src/nfc_manager_ios/pigeon.g.dart',
))
@FlutterApi()
abstract class PigeonFlutterApi {
  void tagReaderSessionDidBecomeActive();
  void tagReaderSessionDidDetect(PigeonTag tag);
  void tagReaderSessionDidInvalidateWithError(PigeonNfcReaderSessionError error);
  void vasReaderSessionDidBecomeActive();
  void vasReaderSessionDidReceive(List<PigeonNfcVasResponse> responses);
  void vasReaderSessionDidInvalidateWithError(PigeonNfcReaderSessionError error);
}

@HostApi()
abstract class PigeonHostApi {
  bool tagReaderSessionReadingAvailable();
  void tagReaderSessionBegin(List<String> pollingOptions, String? alertMessage, bool invalidateAfterFirstRead);
  void tagReaderSessionInvalidate(String? alertMessage, String? errorMessage);
  void tagReaderSessionRestartPolling();
  void tagReaderSessionSetAlertMessage(String alertMessage);
  void vasReaderSessionBegin(List<PigeonNfcVasCommandConfiguration> configurations, String? alertMessage);
  void vasReaderSessionInvalidate(String? alertMessage, String? errorMessage);
  void vasReaderSessionSetAlertMessage(String alertMessage);
  @async PigeonNDEFQueryStatus ndefQueryNDEFStatus(String handle);
  @async PigeonNdefMessage? ndefReadNDEF(String handle);
  @async void ndefWriteNDEF(String handle, PigeonNdefMessage message);
  @async void ndefWriteLock(String handle);
  @async PigeonFeliCaPollingResponse feliCaPolling(String handle, Uint8List systemCode, PigeonFeliCaPollingRequestCode requestCode, PigeonFeliCaPollingTimeSlot timeSlot);
  @async List<Uint8List> feliCaRequestService(String handle, List<Uint8List> nodeCodeList);
  @async int feliCaRequestResponse(String handle);
  @async PigeonFeliCaReadWithoutEncryptionResponse feliCaReadWithoutEncryption(String handle, List<Uint8List> serviceCodeList, List<Uint8List> blockList);
  @async PigeonFeliCaStatusFlag feliCaWriteWithoutEncryption(String handle, List<Uint8List> serviceCodeList, List<Uint8List> blockList, List<Uint8List> blockData);
  @async List<Uint8List> feliCaRequestSystemCode(String handle);
  @async PigeonFeliCaRequestServiceV2Response feliCaRequestServiceV2(String handle, List<Uint8List> nodeCodeList);
  @async PigeonFeliCaRequestSpecificationVersionResponse feliCaRequestSpecificationVersion(String handle);
  @async PigeonFeliCaStatusFlag feliCaResetMode(String handle);
  @async Uint8List feliCaSendFeliCaCommand(String handle, Uint8List commandPacket);
  @async Uint8List miFareSendMiFareCommand(String handle, Uint8List commandPacket);
  @async PigeonISO7816ResponseAPDU miFareSendMiFareISO7816Command(String handle, PigeonISO7816APDU apdu);
  @async PigeonISO7816ResponseAPDU miFareSendMiFareISO7816CommandRaw(String handle, Uint8List data);
  @async PigeonISO7816ResponseAPDU iso7816SendCommand(String handle, PigeonISO7816APDU apdu);
  @async PigeonISO7816ResponseAPDU iso7816SendCommandRaw(String handle, Uint8List data);
  @async void iso15693StayQuiet(String handle);
  @async Uint8List iso15693ReadSingleBlock(String handle, List<String> requestFlags, int blockNumber);
  @async void iso15693WriteSingleBlock(String handle, List<String> requestFlags, int blockNumber, Uint8List dataBlock);
  @async void iso15693LockBlock(String handle, List<String> requestFlags, int blockNumber);
  @async List<Uint8List> iso15693ReadMultipleBlocks(String handle, List<String> requestFlags, int blockNumber, int numberOfBlocks);
  @async void iso15693WriteMultipleBlocks(String handle, List<String> requestFlags, int blockNumber, int numberOfBlocks, List<Uint8List> dataBlocks);
  @async void iso15693Select(String handle, List<String> requestFlags);
  @async void iso15693ResetToReady(String handle, List<String> requestFlags);
  @async void iso15693WriteAfi(String handle, List<String> requestFlags, int afi);
  @async void iso15693LockAfi(String handle, List<String> requestFlags);
  @async void iso15693WriteDsfId(String handle, List<String> requestFlags, int dsfId);
  @async void iso15693LockDsfId(String handle, List<String> requestFlags);
  @async PigeonISO15693SystemInfo iso15693GetSystemInfo(String handle, List<String> requestFlags);
  @async List<int> iso15693GetMultipleBlockSecurityStatus(String handle, List<String> requestFlags, int blockNumber, int numberOfBlocks);
  @async Uint8List iso15693CustomCommand(String handle, List<String> requestFlags, int customCommandCode, Uint8List customRequestParameters);
}

class PigeonTag {
  String? handle;
  PigeonNdef? ndef;
  PigeonFeliCa? feliCa;
  PigeonISO15693? iso15693;
  PigeonISO7816? iso7816;
  PigeonMiFare? miFare;
}

class PigeonNdef {
  PigeonNdefStatus? status;
  int? capacity;
  PigeonNdefMessage? cachedNdefMessage;
}

class PigeonFeliCa {
  Uint8List? currentSystemCode;
  Uint8List? currentIDm;
}

class PigeonISO15693 {
  int? icManufacturerCode;
  Uint8List? icSerialNumber;
  Uint8List? identifier;
}

class PigeonISO7816 {
  String? initialSelectedAID;
  Uint8List? identifier;
  Uint8List? historicalBytes;
  Uint8List? applicationData;
  bool? proprietaryApplicationDataCoding;
}

class PigeonMiFare {
  PigeonMiFareFamily? mifareFamily;
  Uint8List? identifier;
  Uint8List? historicalBytes;
}

class PigeonNDEFQueryStatus {
  PigeonNdefStatus? status;
  int? capacity;
}

class PigeonNdefMessage {
  List<PigeonNdefPayload?>? records;
}

class PigeonNdefPayload {
  PigeonTypeNameFormat? typeNameFormat;
  Uint8List? type;
  Uint8List? identifier;
  Uint8List? payload;
}

class PigeonFeliCaPollingResponse {
  Uint8List? manufacturerParameter;
  Uint8List? requestData;
}

class PigeonFeliCaReadWithoutEncryptionResponse {
  int? statusFlag1;
  int? statusFlag2;
  List<Uint8List?>? blockData;
}

class PigeonFeliCaRequestServiceV2Response {
  int? statusFlag1;
  int? statusFlag2;
  int? encryptionIdentifier;
  List<Uint8List?>? nodeKeyVersionListAES;
  List<Uint8List?>? nodeKeyVersionListDES;
}

class PigeonFeliCaRequestSpecificationVersionResponse {
  int? statusFlag1;
  int? statusFlag2;
  Uint8List? basicVersion;
  Uint8List? optionVersion;
}

class PigeonFeliCaStatusFlag {
  int? statusFlag1;
  int? statusFlag2;
}

class PigeonISO7816APDU {
  int? instructionClass;
  int? instructionCode;
  int? p1Parameter;
  int? p2Parameter;
  Uint8List? data;
  int? expectedResponseLength;
}

class PigeonISO7816ResponseAPDU {
  Uint8List? payload;
  int? statusWord1;
  int? statusWord2;
}

class PigeonISO15693SystemInfo {
  int? dataStorageFormatIdentifier;
  int? applicationFamilyIdentifier;
  int? blockSize;
  int? totalBlocks;
  int? icReference;
}

class PigeonNfcReaderSessionError {
  PigeonNfcReaderErrorCode? code;
  String? message;
}

class PigeonNfcVasCommandConfiguration {
  PigeonNfcVasCommandConfigurationMode? mode;
  String? passIdentifier;
  String? url;
}

class PigeonNfcVasResponse {
  PigeonNfcVasResponseErrorCode? status;
  Uint8List? vasData;
  Uint8List? mobileToken;
}

enum PigeonNdefStatus {
  notSupported,
  readWrite,
  readOnly,
}

enum PigeonTypeNameFormat {
  empty,
  nfcWellKnown,
  media,
  absoluteUri,
  nfcExternal,
  unknown,
  unchanged,
}

enum PigeonFeliCaPollingRequestCode {
  noRequest,
  systemCode,
  communicationPerformance,
}

enum PigeonFeliCaPollingTimeSlot {
  max1,
  max2,
  max4,
  max8,
  max16,
}

enum PigeonMiFareFamily {
  unknown,
  ultralight,
  plus,
  desfire,
}

enum PigeonNfcVasCommandConfigurationMode {
  normal,
  urlOnly,
}

enum PigeonNfcReaderErrorCode {
  readerSessionInvalidationErrorFirstNDEFTagRead,
  readerSessionInvalidationErrorSessionTerminatedUnexpectedly,
  readerSessionInvalidationErrorSessionTimeout,
  readerSessionInvalidationErrorSystemIsBusy,
  readerSessionInvalidationErrorUserCanceled,
  ndefReaderSessionErrorTagNotWritable,
  ndefReaderSessionErrorTagSizeTooSmall,
  ndefReaderSessionErrorTagUpdateFailure,
  ndefReaderSessionErrorZeroLengthMessage,
  readerTransceiveErrorRetryExceeded,
  readerTransceiveErrorTagConnectionLost,
  readerTransceiveErrorTagNotConnected,
  readerTransceiveErrorTagResponseError,
  readerTransceiveErrorSessionInvalidated,
  readerTransceiveErrorPacketTooLong,
  tagCommandConfigurationErrorInvalidParameters,
  readerErrorUnsupportedFeature,
  readerErrorInvalidParameter,
  readerErrorInvalidParameterLength,
  readerErrorParameterOutOfBound,
  readerErrorRadioDisabled,
  readerErrorSecurityViolation,
  unknown,
}

enum PigeonNfcVasResponseErrorCode {
  success,
  userIntervention,
  dataNotActivated,
  dataNotFound,
  incorrectData,
  unsupportedApplicationVersion,
  wrongLCField,
  wrongParameters,
}
