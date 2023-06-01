import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartmkran/app/common/app_config.dart';
import 'package:smartmkran/app/pages/home/logic.dart';
import 'package:flutter/services.dart';


class ImportConfig extends StatefulWidget {
  const ImportConfig({Key? key}) : super(key: key);

  @override
  State<ImportConfig> createState() => _ImportConfigState();
}

class _ImportConfigState extends State<ImportConfig> {
  HomeController homeController = Get.find<HomeController>();
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ایمپورت کانفیگ"),),
      body: SafeArea(

        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text("لطفا کانغیگ را وارد فیلد زیر کنید."),
              SizedBox(height: 10,),
              Container(
                height: 150,
                child: TextField(
                  controller: textEditingController,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(


                    )
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: GetLTRWidget(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: MaterialButton(onPressed: (){
                          homeController.setConfig(textEditingController.text);
                        },child: Text("ایمپورت",style: TextStyle(color: Colors.white),),color: Colors.blue,),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: MaterialButton(onPressed: (){
                         pasteIntextFild();
                        },child: Icon(Icons.paste,color: Colors.white,),color: Colors.green,),
                      ),
                      SizedBox(width: 15,),

                      Expanded(
                        child: MaterialButton(onPressed: (){
                         deleteConfiog();
                        },child: Icon(Icons.delete,color: Colors.white,),color: Colors.red,),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void pasteIntextFild()async{
    Clipboard.getData(Clipboard.kTextPlain).then((value){
     try {
       textEditingController.text = value!.text??"";
     }  catch (e) {
       // TODO
     }

    });
  }

  void deleteConfiog() {
    homeController.deleteConfig();
  }
}
