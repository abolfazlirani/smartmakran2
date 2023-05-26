import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smartmkran/app/pages/home/logic.dart';
import 'package:smartmkran/gen/json/base/pol_model.dart';

import '../../common/RequestInterface.dart';
import '../../common/app_api.dart';

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
    isloading(true);
    HomeController homeController = Get.find<HomeController>();
    var body = {
      "createdAt":DateTime.now().toString(),
      "pond":polModel.id,
      "sensorsKey":homeController.sensorKey,
    };

    if(textEditingController1.text.isNotEmpty){
      body['ph'] = textEditingController1.text;
    }
    if(textEditingController2.text.isNotEmpty){
      body['oxygen'] = textEditingController2.text;
    }
    if(textEditingController3.text.isNotEmpty){
      body['temperature'] = textEditingController3.text;
    }
    if(textEditingController3.text.isNotEmpty){
      body['temperature'] = textEditingController3.text;
    }
    if(textEditingController4.text.isNotEmpty){
      body['orp'] = textEditingController4.text;
    }
    if(textEditingController5.text.isNotEmpty){
      body['ec'] = textEditingController5.text;
    }
    if(textEditingController6.text.isNotEmpty){
      body['ammonia'] = textEditingController6.text;
    }
    if(textEditingController7.text.isNotEmpty){
      body['nitrite'] = textEditingController7.text;
    }
    if(textEditingController8.text.isNotEmpty){
      body['nitrate'] = textEditingController8.text;
    }
    print('SendLocalFormController.sendDataToServer = ${body}');
    apiRequster.request("https://api.smartmakran.ir/sensor", ApiRequster.MHETOD_POST, 1,daynamicUrl: true,
    body: {
      "data":body
    });
  }
  @override
  void onError(String content, int reqCode, String bodyError) {
    // TODO: implement onError
    isloading(false);

  }

  @override
  void onStartReuqest(int reqCode) {
    // TODO: implement onStartReuqest
  }

  @override
  void onSucces(source, int reqCdoe) {
    // TODO: implement onSucces
    isloading(false);

  }
}