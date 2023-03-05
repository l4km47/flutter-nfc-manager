import 'package:ndef_record/ndef_record.dart';
import 'package:nfc_manager/src/nfc_manager_ios/nfc_manager.dart';
import 'package:nfc_manager/src/nfc_manager_ios/pigeon.g.dart';
import 'package:nfc_manager/src/nfc_manager_ios/tags/felica.dart';
import 'package:nfc_manager/src/nfc_manager_ios/tags/mifare.dart';
import 'package:nfc_manager/src/nfc_manager_ios/tags/ndef.dart';

final PigeonHostApi hostApi = PigeonHostApi();

PigeonFeliCaPollingRequestCode feliCaPollingRequestCodeToPigeon(
    FeliCaPollingRequestCodeIOS value) {
  return PigeonFeliCaPollingRequestCode.values
      .firstWhere((e) => e.name == value.name);
}

PigeonFeliCaPollingTimeSlot feliCaPollingTimeSlotToPigeon(
    FeliCaPollingTimeSlotIOS value) {
  return PigeonFeliCaPollingTimeSlot.values
      .firstWhere((e) => e.name == value.name);
}

MiFareFamilyIOS miFareFamilyFromPigeon(PigeonMiFareFamily value) {
  return MiFareFamilyIOS.values.firstWhere((e) => e.name == value.name);
}

NdefStatusIOS ndefStatusFromPigeon(PigeonNdefStatus value) {
  return NdefStatusIOS.values.firstWhere((e) => e.name == value.name);
}

PigeonNfcVasCommandConfigurationMode vasCommandConfigurationModeToPigeon(
    NfcVasCommandConfigurationModeIOS value) {
  return PigeonNfcVasCommandConfigurationMode.values
      .firstWhere((e) => e.name == value.name);
}

NfcReaderErrorCodeIOS readerErrorCodeFromPigeon(
    PigeonNfcReaderErrorCode value) {
  return NfcReaderErrorCodeIOS.values.firstWhere((e) => e.name == value.name);
}

NfcVasResponseErrorCodeIOS vasResponseErrorCodeFromPigeon(
    PigeonNfcVasResponseErrorCode value) {
  return NfcVasResponseErrorCodeIOS.values
      .firstWhere((e) => e.name == value.name);
}

PigeonTypeNameFormat typeNameFormatToPigeon(TypeNameFormat value) {
  switch (value) {
    case TypeNameFormat.empty:
      return PigeonTypeNameFormat.empty;
    case TypeNameFormat.wellKnown:
      return PigeonTypeNameFormat.nfcWellKnown;
    case TypeNameFormat.media:
      return PigeonTypeNameFormat.media;
    case TypeNameFormat.absoluteUri:
      return PigeonTypeNameFormat.absoluteUri;
    case TypeNameFormat.external:
      return PigeonTypeNameFormat.nfcExternal;
    case TypeNameFormat.unknown:
      return PigeonTypeNameFormat.unknown;
    case TypeNameFormat.unchanged:
      return PigeonTypeNameFormat.unchanged;
  }
}

TypeNameFormat typeNameFormatFromPigeon(PigeonTypeNameFormat value) {
  switch (value) {
    case PigeonTypeNameFormat.empty:
      return TypeNameFormat.empty;
    case PigeonTypeNameFormat.nfcWellKnown:
      return TypeNameFormat.wellKnown;
    case PigeonTypeNameFormat.media:
      return TypeNameFormat.media;
    case PigeonTypeNameFormat.absoluteUri:
      return TypeNameFormat.absoluteUri;
    case PigeonTypeNameFormat.nfcExternal:
      return TypeNameFormat.external;
    case PigeonTypeNameFormat.unknown:
      return TypeNameFormat.unknown;
    case PigeonTypeNameFormat.unchanged:
      return TypeNameFormat.unchanged;
  }
}
