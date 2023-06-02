import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:smartmkran/app/pages/offilne/logic.dart';

class OffileStoragePage extends StatefulWidget {
  const OffileStoragePage({Key? key}) : super(key: key);

  @override
  State<OffileStoragePage> createState() => _OffileStoragePageState();
}

class _OffileStoragePageState extends State<OffileStoragePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(OfflineSendLogic(Get.arguments[0]),tag: "mainOfifile").getAllList();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfflineSendLogic>(
      init: OfflineSendLogic(Get.arguments[0]),
      tag: "mainOfifile",
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(
            title: Text("مدیریت رکوست ها"),
          ),
          body: SafeArea(
            child: Container(
              
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(child: ListView(
                    children: logic.mainList.asMap().entries.map((e) {
                      return GetBuilder<SingleOfflineSendLogic>(
                        init:SingleOfflineSendLogic() ,
                        tag: "SingleOfflineSendLogic-${e.key}",
                        builder: (log) {
                          return Container(
                            width: 100.w,
                            margin: EdgeInsets.symmetric(vertical: 1.h),
                            height: 7.h,
                            decoration: BoxDecoration(
                              border: Border.all(color:e.value.sended?Colors.green: Colors.red),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(e.value.title),
                                        Text(" . "),
                                        Text(_getDate(e.value.createdAt),textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.5)
                                        ),),
                                      ],
                                    ),
                                    Text(!e.value.sended?"ارسال نشده":"ارسال شده",style: TextStyle(color: e.value.sended?Colors.green:Colors.red,
                                    fontSize: 9),),
                                  ],
                                ),
                               if(e.value.sended==false) Container(

                                  child: MaterialButton(onPressed: (){

                                    log.sendPostRequest(e.value,logic);

                                  },child: Text("ارسال",style: TextStyle(color: Colors.white),),color: Colors.blue,),
                                ),
                               if(e.value.sended!=false) Container(

                                  child: Icon(Icons.check,color: Colors.green,),
                                ),

                              ],
                            ),
                          );
                        }
                      );
                    }).toList(),
                  ),)
                ],
              ),
            ),
          ),

        );
      }
    );
  }

  String _getDate(String createdAt) {
    print('_OffileStoragePageState._getDate = ${createdAt}');
    DateTime dateTime = DateTime.parse(createdAt);
    Jalali jalali  = dateTime.toJalali();
    String das = "${jalali.year}/${jalali.month}/${jalali.day} - ${jalali.hour}:${jalali.minute} ";
    return das;
  }
}
