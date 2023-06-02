import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:smartmkran/app/common/offline_storage.dart';

import '../../../gen/model/off.dart';

class OfflineSendLogic extends GetxController{
  List<OfflineSendedModel> mainList = [ ];

  String pound;

  OfflineSendLogic(this.pound);

 late OfflineStorage storage;


  @override
  void onInit() {
    super.onInit();
    storage = OfflineStorage(pound);
  }

  getAllList()async{
    mainList = await storage.getAllModels();
    print('OfflineSendLogic.getAllList = ${mainList.length}');
    update();
  }
  static final Dio _dio = Dio();

  Future<void> sendPostRequest(OfflineSendedModel model) async {
    try {
      final String requestUrl = model.url;
      final dynamic requestBody = jsonDecode(model.body);

      final response = await _dio.post(requestUrl, data: requestBody);

      if (response.statusCode == 200) {
        // Successful response
        print('POST request sent successfully');
        // Update the status of the model as "sended" if needed
        // Example: OfflineStorage().changeStatusModel(model.id, true);
      } else {
        // Handle error response
        print('Error sending POST request: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception occurred during POST request: $e');
    }
  }
}
class SingleOfflineSendLogic extends GetxController{
  static final Dio _dio = Dio();

  var isloading = false.obs;
  Future<void> sendPostRequest(OfflineSendedModel model,OfflineSendLogic logic) async {
    try {
      final String requestUrl = model.url;
      final dynamic requestBody = jsonDecode(model.body);
      print('SingleOfflineSendLogic.sendPostRequest = ${requestUrl} - ${requestBody}');

      final response = await _dio.post(requestUrl, data: requestBody);

      if (response.statusCode == 200) {
        // Successful response
        print('POST request sent successfully');
        // Update the status of the model as "sended" if needed
        // Example: OfflineStorage().changeStatusModel(model.id, true);
        logic.storage.changeStatusModel(model.id, true);
        logic.getAllList();
      } else {
        // Handle error response
        print('Error sending POST request: ${response.statusCode}');
      }
    }on DioError catch (e) {
      // Handle exceptions
      print('Exception occurred during POST request: ${e.response}');
    }
  }
}