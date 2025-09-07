class KeyValueModel {
  final String? key;
  final dynamic value;
  List<KeyValueModel> listKeyValueModel = [];
  KeyValueModel({
    this.key,
    this.value,
  });

  List<KeyValueModel> getListKeyValueModel(Map<String, dynamic> json) {
    listKeyValueModel = json.entries
        .map(
          (entry) => KeyValueModel(key: entry.key, value: entry.value),
        )
        .toList();
    return listKeyValueModel;
  }
}
