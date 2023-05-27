import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartmkran/app/pages/send_local_form/logic.dart';
import 'package:smartmkran/gen/json/base/pol_model.dart';

import '../home/logic.dart';
import 'logic.dart';

class SendLocalFormPage2 extends StatelessWidget {
  PolModel polModel;

  SendLocalFormPage2(this.polModel){
    sendLocalFormController = Get.put(SendLocalFormController2(polModel));
  }

  HomeController homeController = Get.find<HomeController>();
 late SendLocalFormController2 sendLocalFormController ;

 TextEditingController textEditingController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SendLocalFormController2>(
        init: sendLocalFormController,
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              title: Text('ارسال  فرم شـــــفافیت ' ),
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
                          hintText: 'شفافیت',
                          labelText: 'شفافیت',
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
