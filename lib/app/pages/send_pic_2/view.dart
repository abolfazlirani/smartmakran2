import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartmkran/app/pages/send_pic/logic.dart';
import 'package:smartmkran/gen/json/base/pol_model.dart';

class SendImagePage2 extends StatefulWidget {
  PolModel polModel;

  SendImagePage2(this.polModel);

  @override
  State<SendImagePage2> createState() => _SendImagePage2State();
}

class _SendImagePage2State extends State<SendImagePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ارسال تصویر ماژول حسگری"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [

              GetBuilder<SendPicLogic>(
                  init: SendPicLogic(widget.polModel),
                  tag: "image_${10+1}",
                  builder: (logic) {

                    File? file = logic.file1;
                    print('_SendImagePageState.build = ${logic.file1}');
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(logic.isNull?"فایل هنوز انتخاب نشده":"انتخاب شده",overflow: TextOverflow.ellipsis,),),
                              if(!logic.isNull&&logic.isLoading==false) Container(

                                child: MaterialButton(onPressed: (){

                                  logic.uploadImage();
                                },child: Text("ارسال به سمت سرور",style: TextStyle(color: Colors.white),),color: Colors.blue,),
                              ),
                              if(logic.isNull) MaterialButton(onPressed: (){

                                logic.getFromCamera(logic.file1);
                              },child: Text("انتخاب تصویر",style: TextStyle(color: Colors.white),),color: Colors.red,),
                              if(logic.isLoading)Container(
                                child: Obx(
                                        () {
                                      print('_SendImagePageState.build = ${logic.progress.value}');
                                      return CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                        // value: logic.progress.value/100,
                                        strokeWidth: 3,
                                        color: Colors.blue,
                                      );
                                    }
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          if(!logic.isNull) Image.file(logic.files.elementAt(0)),

                        ],
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
