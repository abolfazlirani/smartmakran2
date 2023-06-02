import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartmkran/app/pages/home/logic.dart';
import 'package:smartmkran/gen/json/base/pol_model.dart';

import '../../common/RequestInterface.dart';
import '../../common/app_api.dart';

class SendLocalFormControlle4 extends GetxController implements RequestInterface{

  PolModel polModel;
  TextEditingController textEditingController1  = TextEditingController();
  TextEditingController textEditingController2  = TextEditingController();


  late ApiRequster apiRequster;

  var isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    apiRequster = ApiRequster(this,develperModel: true);
  }


  SendLocalFormControlle4(this.polModel);

  sendDataToServer()async{
   // isloading(true);
    HomeController homeController = Get.find<HomeController>();
    var body = {
      "createdAt":DateTime.now().toString(),
      "pond":polModel.id,
      "amount":int.parse(textEditingController1.text),
      "sensorsKey":homeController.sensorKey,
    };


    print('SendLocalFormController.sendDataToServer = ${body}');
    OfflineStorage(polModel.id).saveOneModel(OfflineSendedModel(id: 1, title: "  ثبت تعویض آب", url: "https://api.smartmakran.ir/manualMonitoring/changingWater", body: jsonEncode(body), createdAt: "", savedAt: "", sended: false, pound: polModel.id));

    // apiRequster.request("https://api.smartmakran.ir/manualMonitoring/changingWater", ApiRequster.MHETOD_POST, 1,daynamicUrl: true,
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