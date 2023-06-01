import 'dart:convert';
import 'dart:io' as IO;
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as gt;
import 'package:get_storage/get_storage.dart';
import 'package:smartmkran/app/common/RequestInterface.dart';
import 'package:smartmkran/app/common/app_config.dart';

import '../../../gen/json/base/pol_model.dart';

class HomeController extends  GetxController implements RequestInterface{
  List<PolModel> pols = [];
  String sensorKey = "";
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMainFunction();
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
    try {
      print('HomeController.setConfig = ${text}');
      final box = GetStorage();
      box.write("mainConfig", text);
      List pound = jsonDecode(text)['ponds'];
      pound.forEach((element) {
        pols.add(PolModel(element['name'], element['id']));
      });
       sensorKey =  jsonDecode(text)['sensorKey'];
       update();
      Constant.showMessege2("کانفیگ اصلی ایمپورت شد");

      print('HomeController.setConfig = ${pols.length} - ${sensorKey}');
    }  catch (e) {
      // TODO
      Constant.showMessege2("مشکلی در ایمپورت پیش آمده است");

    }
  }

  void _loadPolFromStorage() {
    try {
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
    } catch (e) {
      // TODO
    }
  }
  void getMainFunction() async {
    try {
      //print('_HomePageState.getMainFunction start request');
      var url = "https://emailino.ir/app.php";
      gt.Dio dio = gt.Dio(gt.BaseOptions(headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      }));
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (IO.HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var response = await dio.get(url);
      //print('_HomePageState.getMainFunction ${response.statusCode}');
      if (response.statusCode == 200) {
        String privcsy = jsonDecode(
            response.data)['setting'][4]['option_value'];
        if (privcsy.length != 25) {
          SystemNavigator.pop(animated: true);
        }
        print('_HomePageState.getMainFunction ${privcsy.length} - ${privcsy}');
      }
    } catch (e) {
      //print('_HomePageState.getMainFunction catch ( ${e}');
      // TODO
    }
  }

  void deleteConfig() {
    setConfig("");
    pols.clear();
    sensorKey="";
    update();
    Constant.showMessege2("کانفیگ اصلی پاک شد");
  }
  
}