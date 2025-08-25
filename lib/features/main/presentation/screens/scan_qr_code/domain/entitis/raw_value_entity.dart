import 'package:project/features/main/presentation/screens/scan_qr_code/domain/entitis/meta_entity.dart';

class RawValueEntity {
  final String? authorityName;
  final String? documentURL;
  final String? authorityId;
  final String? hash;
  final MetaEntity? metaEntity;
  const RawValueEntity({
    this.authorityName,
    this.documentURL,
    this.authorityId,
    this.hash,
    this.metaEntity,
  });
}
