import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../gen/model/off.dart';
import '../widgets/off_storage_dialog.dart';

class OfflineStorage {
  final String pound;
  final String _boxKey;

  OfflineStorage(this.pound) : _boxKey = 'offline_sended_models_$pound';
  Future<List<OfflineSendedModel>> getAllModels() async {
    final box = GetStorage();
    final List<dynamic>? jsonList = box.read<List<dynamic>>(_boxKey);

    print('OfflineStorage.getAllModels = ${box.read(_boxKey)}');
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
    final List<dynamic> jsonList = box.read<List<dynamic>>(_boxKey)??[];

    final int lastId = jsonList.isEmpty ? 0 : jsonList.last['id'];
    final newId = lastId + 1;
    final DateTime now = DateTime.now();
    final String timestamp = now.toString();

    final updatedModel = OfflineSendedModel(
      id: newId,
      title: model.title,
      url: model.url,
      body: model.body,
      createdAt: timestamp,
      savedAt: timestamp,
      pound: model.pound,
      sended: false,
    );

    jsonList.add(updatedModel.toJson());
    box.write(_boxKey, jsonList);
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return OffStorageDialog(model);
      },
    );

    print('OfflineStorage.saveOneModel');
  }

  Future<void> changeStatusModel(int id, bool newStatus) async {
    final box = GetStorage();
    final List<dynamic>? jsonList = box.read<List<dynamic>>(_boxKey);

    if (jsonList != null) {
      final int modelIndex =
      jsonList.indexWhere((json) => json['id'] == id);

      if (modelIndex != -1) {
        final Map<String, dynamic> modelJson = jsonList[modelIndex];
        final DateTime now = DateTime.now();
        final String savedAt = now.toString();

        modelJson['sended'] = newStatus;
        modelJson['savedAt'] = savedAt;
        jsonList[modelIndex] = modelJson;

        box.write(_boxKey, jsonList);
      }
    }
  }
}
