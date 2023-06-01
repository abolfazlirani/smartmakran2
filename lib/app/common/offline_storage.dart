import 'package:get_storage/get_storage.dart';

import '../../gen/model/off.dart';

class OfflineStorage {
  final String _boxKey = 'offline_sended_models';

  Future<List<OfflineSendedModel>> getAllModels() async {
    final box = GetStorage();
    final List<dynamic>? jsonList = box.read<List<dynamic>>(_boxKey);

    if (jsonList != null) {
      List<OfflineSendedModel> models = jsonList
          .map((json) => OfflineSendedModel.fromJson(json))
          .toList()
          .cast<OfflineSendedModel>();
      return models;
    }

    return [];
  }

  Future<void> saveOneModel(OfflineSendedModel model) async {
    final box = GetStorage();

    List<dynamic> jsonList = box.read<List<dynamic>>(_boxKey) ?? [];
    final int modelIndex = jsonList.indexWhere((json) => json['id'] == model.id);

    if (modelIndex != -1) {
      jsonList[modelIndex] = model.toJson();
    } else {
      jsonList.add(model.toJson());
    }

    box.write(_boxKey, jsonList);
  }

  Future<void> changeStatusModel(int id, bool newStatus) async {
    final box = GetStorage();

    List<dynamic> jsonList = box.read<List<dynamic>>(_boxKey) ?? [];
    final int modelIndex =
    jsonList.indexWhere((json) => json['id'] == id);

    if (modelIndex != -1) {
      final Map<String, dynamic> modelJson = jsonList[modelIndex];
      modelJson['sended'] = newStatus;
      jsonList[modelIndex] = modelJson;

      box.write(_boxKey, jsonList);
    }
  }
}
