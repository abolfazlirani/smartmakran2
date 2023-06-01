import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartmkran/app/pages/send_local_form/logic.dart';
import 'package:smartmkran/gen/json/base/pol_model.dart';

import '../home/logic.dart';
import 'logic.dart';

class SendLocalFormPage3 extends StatelessWidget {
  PolModel polModel;

  SendLocalFormPage3(this.polModel){
    sendLocalFormController = Get.put(SendLocalFormControlle3(polModel));
  }

  HomeController homeController = Get.find<HomeController>();
 late SendLocalFormControlle3 sendLocalFormController ;

 TextEditingController textEditingController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SendLocalFormControlle3>(
        init: sendLocalFormController,
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              title: Text('ارسال  ثبت غذادهی ' ),
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
                          hintText: 'میزان غذادهی',
                          labelText: 'میزان غذادهی',
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
                          hintText: 'نوع غـذا',
                          labelText: 'نوع غـذا',
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
