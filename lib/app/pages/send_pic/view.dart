import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartmkran/app/pages/send_pic/logic.dart';
import 'package:smartmkran/gen/json/base/pol_model.dart';

class SendImagePage extends StatefulWidget {
  PolModel polModel;

  SendImagePage(this.polModel);

  @override
  State<SendImagePage> createState() => _SendImagePageState();
}

class _SendImagePageState extends State<SendImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ارسال تصویر"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [

              ...List.generate(5, (index) => GetBuilder<SendPicLogic>(
                  init: SendPicLogic(widget.polModel),
                  tag: "image_${index+1}",
                  builder: (logic) {

                    File? file = logic.file1;
                    print('_SendImagePageState.build = ${logic.file1}');
                    return Row(
                      children: [
                        Text("فایل ${index+1} :  "),
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
                    );
                  }
              )).toList()
            ],
          ),
        ),
      ),
    );
  }
}
