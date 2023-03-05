import 'package:ndef_record/ndef_record.dart';
import 'package:nfc_manager/src/nfc_manager_android/pigeon.g.dart';
import 'package:nfc_manager/src/nfc_manager_android/tags/mifare_classic.dart';
import 'package:nfc_manager/src/nfc_manager_android/tags/mifare_ultralight.dart';

final PigeonHostApi hostApi = PigeonHostApi();

MifareClassicTypeAndroid mifareClassicTypeFromPigeon(
    PigeonMifareClassicType value) {
  return MifareClassicTypeAndroid.values
      .firstWhere((e) => e.name == value.name);
}

MifareUltralightTypeAndroid mifareUltralightTypeFromPigeon(
    PigeonMifareUltralightType value) {
  return MifareUltralightTypeAndroid.values
      .firstWhere((e) => e.name == value.name);
}

PigeonTypeNameFormat typeNameFormatToPigeon(TypeNameFormat value) {
  switch (value) {
    case TypeNameFormat.empty:
      return PigeonTypeNameFormat.empty;
    case TypeNameFormat.wellKnown:
      return PigeonTypeNameFormat.wellKnown;
    case TypeNameFormat.media:
      return PigeonTypeNameFormat.mimeMedia;
    case TypeNameFormat.absoluteUri:
      return PigeonTypeNameFormat.absoluteUri;
    case TypeNameFormat.external:
      return PigeonTypeNameFormat.externalType;
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
    case PigeonTypeNameFormat.wellKnown:
      return TypeNameFormat.wellKnown;
    case PigeonTypeNameFormat.mimeMedia:
      return TypeNameFormat.media;
    case PigeonTypeNameFormat.absoluteUri:
      return TypeNameFormat.absoluteUri;
    case PigeonTypeNameFormat.externalType:
      return TypeNameFormat.external;
    case PigeonTypeNameFormat.unknown:
      return TypeNameFormat.unknown;
    case PigeonTypeNameFormat.unchanged:
      return TypeNameFormat.unchanged;
  }
}
