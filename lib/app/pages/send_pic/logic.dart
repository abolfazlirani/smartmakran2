import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:image_picker/image_picker.dart';
import 'package:smartmkran/app/common/app_config.dart';
import 'package:smartmkran/app/common/offline_storage.dart';
import 'package:smartmkran/app/pages/offilne/logic.dart';
import 'package:smartmkran/app/widgets/off_storage_dialog.dart';
import 'package:smartmkran/gen/json/base/pol_model.dart';
import 'package:smartmkran/gen/model/off.dart';

import '../home/logic.dart';

class SendPicLogic extends GetxController{
  bool isNull = true;
  bool isLoading = false;

  var progress = (0.0).obs;
  File file1 = File("");
  List<File> files =[];

  PolModel polModel;
  SendPicLogic(this.polModel);
  getFromCamera(File? file1) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
      imageQuality: 30
    );
    if (pickedFile != null) {
       file1 = File(pickedFile.path);
       files.add(file1);
       isNull=false;
    }
    print('SendPicLogic.getFromCamera = ${pickedFile} - ${file1}');

    update();
  }

  Future<void> uploadImage(type) async {
    HomeController homeController = Get.find<HomeController>();

   // isLoading = true;
    update();
    String url = 'https://api.smartmakran.ir/pond/add-image'; // Replace with your upload URL

    try {
      DIO.Dio dio =  DIO.Dio();
      var body = {
        'file': files.elementAt(0).readAsBytesSync(),
        "type":type,
        "pondId":"${polModel.id}",
        "sensorKey":"${homeController.sensorKey}",
        "createdAt":"${DateTime.now().toString()}",
      };
      DIO. FormData formData =  DIO.FormData.fromMap(body);

     // log('SendPicLogic.uploadImage = 1 = ${body}');
      OfflineStorage(polModel.id).saveOneModel(OfflineSendedModel(id: 1, title: "ارسال تصویر ", url: url, body: jsonEncode({
        'file': files.elementAt(0).readAsBytesSync()
        ,
        "type":type,
        "pondId":"${polModel.id}",
        "sensorKey":"${homeController.sensorKey}",
        "createdAt":"${DateTime.now().toString()}",
      }),
          createdAt: "", savedAt: "", sended: false, pound: polModel.id));
      // DIO.Response response = await dio.post(url, data: formData,
      //     onSendProgress: (int count, int total){
      //    progress  = ((count*100)/total).obs;
      //    update();
      // print('SendPicLogic.uploadImage = 3 = $progress');
      // });
      // print('SendPicLogic.uploadImage = 2 = ${response.statusCode} - ${response.data}');
      // isLoading = false;
      //
      // update();
      // print('Upload successful! Response: ${response.data}');
      Constant.showMessege2("تصویر با موفقیت سمت سرور ارسال شد");


    }on DIO.DioError catch  (error) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(error.response.toString())));
      print('Error uploading image: ${error.response}');
      isLoading = false;

      update();
    }
  }


}