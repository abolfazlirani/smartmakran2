import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartmkran/app/pages/home/import_config.dart';
import 'package:smartmkran/app/pages/home/menu/view.dart';
import 'package:smartmkran/app/pages/send_local_form/view.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: homeController,
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(
            title: Text('صفحه اصلی '),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'ایمپورت کانفیگ'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ایدی کارشناس:",style: TextStyle(color: Colors.black.withOpacity(0.3)),),
                        Text("${logic.sensorKey}",style: TextStyle(color: Colors.black.withOpacity(0.3)),)
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: Column(
                        children: logic.pols.asMap().entries.map((e) => Container(

                          height: 40,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.red.withOpacity(0.5))
                          ),
                          child: MaterialButton(
                            padding: EdgeInsets.all(8),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),

                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (builder)=>MenuPage(e.value)));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.value.name),
                                Text(e.value.id),
                              ],
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                    

                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
  void handleClick(String value) {
    Get.to(ImportConfig());
  }
}
