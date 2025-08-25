import 'package:project/features/main/presentation/screens/scan_qr_code/data/models/key_value_model.dart';
import 'package:project/features/main/presentation/screens/scan_qr_code/domain/entitis/raw_value_entity.dart';

class RawValueModel {
  final String? authorityName;
  final String? documentURL;
  final String? authorityId;
  final String? hash;
  final List<KeyValueModel>? listKeyValueModel;

  const RawValueModel({
    this.authorityName,
    this.documentURL,
    this.authorityId,
    this.hash,
    this.listKeyValueModel,
  });
  factory RawValueModel.fromBarcode(Map<String, dynamic> json) {
    return RawValueModel(
      authorityName: json['AuthorityName'],
      documentURL: json['DocumentURL'],
      authorityId: json['AuthorityId'],
      hash: json['Hash'],
      listKeyValueModel: KeyValueModel().getListKeyValueModel(json['MetaData']),
    );
  }

  RawValueEntity toEntity() {
    return RawValueEntity(
      authorityName: authorityName,
      documentURL: documentURL,
      hash: hash,
      authorityId: authorityId,
    );
  }
}
