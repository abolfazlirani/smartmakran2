import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartmkran/app/pages/send_local_form/logic.dart';
import 'package:smartmkran/gen/json/base/pol_model.dart';

import '../home/logic.dart';

class SendLocalFormPage extends StatelessWidget {
  PolModel polModel;

  SendLocalFormPage(this.polModel){
    sendLocalFormController = Get.put(SendLocalFormController(polModel));
  }

  HomeController homeController = Get.find<HomeController>();
 late SendLocalFormController sendLocalFormController ;

 TextEditingController textEditingController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SendLocalFormController>(
        init: sendLocalFormController,
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              title: Text('استخر‌: ' + logic.polModel.name),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: logic.textEditingController1,
                          decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.red)
                    ),
                          hintText: 'pH',
                          labelText: 'pH',
          )),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: logic.textEditingController2,
                          decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.red)
                    ),
                          hintText: 'اکســیژن محلول در آب',
                          labelText: 'اکســیژن محلول در آب',
          )),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: logic.textEditingController3,
                          decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.red)
                    ),
                          hintText: 'دمـا',
                          labelText: 'دمـا',
          )),
                        ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                  controller: logic.textEditingController4,
                                  decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.red)
                                    ),
                                    hintText: 'ORP',
                                    labelText: 'ORP',
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                  controller: logic.textEditingController5,
                                  decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.red)
                                    ),
                                    hintText: 'شـــــــوری',
                                    labelText: 'شـــــــوری',
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                  controller: logic.textEditingController6,
                                  decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.red)
                                    ),
                                    hintText: 'آمونیوم',
                                    labelText: 'آمونیوم',
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                  controller: logic.textEditingController7,
                                  decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.red)
                                    ),
                                    hintText: 'نیتریـت',
                                    labelText: 'نیتریـت',
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                  controller: logic.textEditingController8,
                                  decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.red)
                                    ),
                                    hintText: 'نیترات',
                                    labelText: 'نیترات',
                                  )),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),
                      child: MaterialButton(onPressed: (){
                       logic.sendDataToServer();
                      },child: Text("ارسال اطلاعات به سمت سرور",style: TextStyle(color: Colors.white),),color: Colors.blue,),
                    ),
                  ),
                  Obx(() => logic.isloading.value? Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),

                    ),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ):Container())
                ],
              ),
            ),
          );
        }
    );
  }
}
