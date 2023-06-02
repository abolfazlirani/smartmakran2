import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartmkran/app/pages/home/logic.dart';
import 'package:smartmkran/gen/json/base/pol_model.dart';

import '../../../gen/model/off.dart';
import '../../common/RequestInterface.dart';
import '../../common/app_api.dart';
import '../../common/offline_storage.dart';

class SendLocalFormController extends GetxController implements RequestInterface{

  PolModel polModel;
  TextEditingController textEditingController1  = TextEditingController();
  TextEditingController textEditingController2  = TextEditingController();
  TextEditingController textEditingController3  = TextEditingController();
  TextEditingController textEditingController4  = TextEditingController();
  TextEditingController textEditingController5  = TextEditingController();
  TextEditingController textEditingController6  = TextEditingController();
  TextEditingController textEditingController7  = TextEditingController();
  TextEditingController textEditingController8  = TextEditingController();

  late ApiRequster apiRequster;

  var isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    apiRequster = ApiRequster(this,develperModel: true);
  }


  SendLocalFormController(this.polModel);

  sendDataToServer()async{
    //isloading(true);
    HomeController homeController = Get.find<HomeController>();
    Map<String,dynamic> body = {
      "createdAt":DateTime.now().toString(),
      "pond":polModel.id,
      "sensorsKey":homeController.sensorKey,
    };

    if(textEditingController1.text.isNotEmpty){

      body['ph'] = double.parse(textEditingController1.text);
    }
    if(textEditingController2.text.isNotEmpty){
      body['oxygen'] = int.parse(textEditingController2.text);

    }
    if(textEditingController3.text.isNotEmpty){
      body['temperature'] = int.parse(textEditingController3.text);

    }

    if(textEditingController4.text.isNotEmpty){
      body['orp'] = int.parse(textEditingController4.text);

    }
    if(textEditingController5.text.isNotEmpty){
      body['ec'] = int.parse(textEditingController5.text);

    }
    if(textEditingController6.text.isNotEmpty){
      body['ammonia'] = int.parse(textEditingController6.text);

    }
    if(textEditingController7.text.isNotEmpty){
      body['nitrite'] = int.parse(textEditingController7.text);

    }
    if(textEditingController8.text.isNotEmpty){
      body['nitrate'] = double.parse(textEditingController8.text);

    }
    print('SendLocalFormController.sendDataToServer = ${jsonEncode({
      "data":body,"d":2
    })}');
    OfflineStorage(polModel.id).saveOneModel(OfflineSendedModel(id: 1, title: " کیفیت آب به صورت دستی ", url: "https://api.smartmakran.ir/manualMonitoring/sensor", body: jsonEncode(body), createdAt: "", savedAt: "", sended: false, pound: polModel.id));
    // apiRequster.request("https://api.smartmakran.ir/sensor", ApiRequster.MHETOD_POST, 1,daynamicUrl: true,
    // body: body);
  }
  @override
  void onError(String content, int reqCode, String bodyError) {
    // TODO: implement onError
    isloading(false);

    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(jsonDecode(bodyError)['message'][0])));
  }

  @override
  void onStartReuqest(int reqCode) {
    // TODO: implement onStartReuqest
  }

  @override
  void onSucces(source, int reqCdoe) {
    // TODO: implement onSucces
    isloading(false);
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text("ارسال اطلاعات با موفقیت انجام شد")));

  }
}