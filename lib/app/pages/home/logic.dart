import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartmkran/app/common/RequestInterface.dart';

import '../../../gen/json/base/pol_model.dart';

class HomeController extends  GetxController implements RequestInterface{
  List<PolModel> pols = [];
  String sensorKey = "";
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loadPolFromStorage();
  }
  @override
  void onError(String content, int reqCode, String bodyError) {
    // TODO: implement onError
  }

  @override
  void onStartReuqest(int reqCode) {
    // TODO: implement onStartReuqest
  }

  @override
  void onSucces(source, int reqCdoe) {
    // TODO: implement onSucces
  }

  void setConfig(String text) {
    print('HomeController.setConfig = ${text}');
    final box = GetStorage();
    List pound = jsonDecode(text)['ponds'];
    box.write("mainConfig", text);
    pound.forEach((element) {
      pols.add(PolModel(element['name'], element['id']));
    });
     sensorKey =  jsonDecode(text)['sensorKey'];
     update();
    print('HomeController.setConfig = ${pols.length} - ${sensorKey}');
  }

  void _loadPolFromStorage() {
    final box = GetStorage();
    if (box.read("mainConfig")!=null) {
      String text = box.read("mainConfig")!;
    List pound = jsonDecode(text)['ponds'];
      pound.forEach((element) {
        pols.add(PolModel(element['name'], element['id']));
      });
      sensorKey =  jsonDecode(text)['sensorKey'];
      update();
      print('HomeController.setConfig = ${pols.length} - ${sensorKey}');
    }
  }
  
  
}