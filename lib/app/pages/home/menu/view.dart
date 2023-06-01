import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartmkran/app/pages/blutouth/HomePage.dart';
import 'package:smartmkran/app/pages/send_local_form/view.dart';
import 'package:smartmkran/app/pages/send_local_form_2/view.dart';
import 'package:smartmkran/app/pages/send_local_form_3/view.dart';
import 'package:smartmkran/app/pages/send_local_form_4/view.dart';
import 'package:smartmkran/app/pages/send_local_form_5/view.dart';
import 'package:smartmkran/app/pages/send_local_form_6/view.dart';
import 'package:smartmkran/app/pages/send_pic/view.dart';

import '../../../../gen/json/base/pol_model.dart';
import '../../../common/app_config.dart';
import '../../send_pic_2/view.dart';

class MenuPage extends StatelessWidget {
  PolModel polModel;


  MenuPage(this.polModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("انتخاب نوع ارسال"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>SendLocalFormPage(polModel)));

                },child: Text("کیفیت آب به صورت دستی",style: TextStyle(color: Colors.white),),color: Colors.blue,),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>SendImagePage(polModel)));

                },child: Text("ثبت زیست ستجی",style: TextStyle(color: Colors.white),),color: Colors.blue,),
              ),
               SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>SendImagePage2(polModel)));

                },child: Text("ثبت کیفیت آب به کمک تصویر",style: TextStyle(color: Colors.white),),color: Colors.blue,),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>SendLocalFormPage2(polModel)));

                },child: Text("ثبت شفافیت",style: TextStyle(color: Colors.white),),color: Colors.blue,),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>SendLocalFormPage3(polModel)));

                },child: Text("ثبت غذادهی",style: TextStyle(color: Colors.white),),color: Colors.blue,),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>SendLocalFormPage6(polModel)));

                },child: Text("ثبت چک غذا",style: TextStyle(color: Colors.white),),color: Colors.blue,),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>SendLocalFormPage4(polModel)));

                },child: Text("ثبت تعویض آب",style: TextStyle(color: Colors.white),),color: Colors.blue,),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>SendLocalFormPage5(polModel)));

                },child: Text("ثبت تلفات",style: TextStyle(color: Colors.white),),color: Colors.blue,),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>HomePages()));

                },child: Text("کیفیت آب به کمک بلوتوث",style: TextStyle(color: Colors.white),),color: Colors.blue,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
