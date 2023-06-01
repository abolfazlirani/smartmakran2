// ignore_for_file: file_names
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'package:dio/dio.dart' as gt;
import 'package:sizer/sizer.dart';
import 'package:smartmkran/app/common/app_color.dart';
import 'dart:io' as IO;
import 'dart:io' ;

import 'FromJsonGetSensorModel.dart';
import 'components/ButtonDouble.dart';
import 'components/VoiceButtonPage.dart';

class ControlePrincipalPage extends StatefulWidget {
  final BluetoothDevice? server;
  const ControlePrincipalPage({this.server});

  @override
  _ControlePrincipalPage createState() => _ControlePrincipalPage();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ControlePrincipalPage extends State<ControlePrincipalPage> {
  static const clientID = 0;
  BluetoothConnection? connection;
  String? language;

 // List<FromJsonGetSensorModel> _models = [ ];
  FromJsonGetSensorModel model = FromJsonGetSensorModel(ph: 0, orp: 0,oxygen: 0,temperature: 0,ammonia: 0,nitrate: 0,nitrite: 0);
  // ignore: deprecated_member_use
  List<_Message> messages = <_Message>[];
  String _messageBuffer = '';

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  bool isConnecting = true;
  bool get isConnected => connection != null && connection!.isConnected;

  bool isDisconnecting = false;
  bool buttonClicado = false;
  Timer? timer;

  bool _isLoading = false;
  List<String> _languages = ['en_US', 'es_ES', 'pt_BR'];

  @override
  void initState() {
    super.initState();
    BluetoothConnection.toAddress(widget.server!.address).then((_connection) {
      print('Connected to device ');

      _connection.input!.listen((event) {

        String messege = Utf8Decoder().convert(event);

        setState((){
          _messageBuffer += "${messege}" + "\n";
        });
        try {
          var json = jsonDecode(messege.replaceAll("'", '"'));

          try {
           // _models.add(FromJsonGetSensorModel.fromJson(json));
            model = FromJsonGetSensorModel.fromJson(json);
          }  catch (e) {
            // TODO
          }
          json['ammonia'] = 0;
          json['nitrite'] = 0;
          json['nitrate'] = 0;
          setState(() {

          });
         // sendDataToServer(json);
        }  catch (e) {
          // TODO
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("اطلاعات ارسالی قابل پارس کردن نمیباشد.",textAlign: TextAlign.right,),backgroundColor: Colors.red,));

        }
      });
      connection = _connection;
      setState(() {
        
        isConnecting = false;
        isDisconnecting = false;
      });


      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          try {
            timer!.cancel();
          }  catch (e) {
            // TODO
          }
          print('Disconnected localy!');
        } else {
          try {
            timer!.cancel();
          }  catch (e) {
            // TODO
          }
          print('Disconnected remote!');
        }

        print('_ControlePrincipalPage.initState');
      });


      print('_ControlePrincipalPage.initState 5 ');
      timer=  Timer.periodic(Duration(), (timer) {
        _sendMessage();
        print('_ControlePrincipalPage.initState');
      });
    }).catchError((error) {
      print('Failed to connect, something is wrong!');
      print(error);
    });

  }
  void sendDataToServer(jsons) async {

    setState((){
      _isLoading=true;
    });
    final staticHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    try {
      print('_HomePageState.getMainFunction start request');
      var url = "https://api.smartmakran.ir/sensor";
      gt.Dio dio = gt.Dio(gt.BaseOptions(headers: staticHeaders));

      var response = await dio.post(url,data: jsons);
      print('_HomePageState.getMainFunction ${response.statusCode}');

      if(response.statusCode! >=200&&response.statusCode! <300){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("با موفقیت به سرور ارسال شد",textAlign: TextAlign.right,),backgroundColor: Colors.green,));

      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("مشکلی در ارسال به سمت سرور وجود دارد",textAlign: TextAlign.right,),backgroundColor: Colors.red,));

      }
      setState((){
        _isLoading=false;
      });


    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("مشکلی در ارسال به سمت سرور وجود دارد 2",textAlign: TextAlign.right,),backgroundColor: Colors.red,));

      print('_HomePageState.getMainFunction catch ( ${e}');
      // TODO
    }
  }
  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection!.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    messages.map((_message) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
                (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_message.text.trim()),
                style: const TextStyle(color: Colors.white)),
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color:
                    _message.whom == clientID ? Colors.blueAccent : Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
          ),
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();

    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                  /*  Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(children: [
                              ButtonDoubleComponent(
                                buttonName: "دریافت وضعیت",
                                comandOn: 'm',
                                comandOff: 'm',
                                clientID: clientID,
                                connection: connection,
                              ),
                            ]),
                            const SizedBox(width: 30),



                          ]),
                    ),*/

                   /* Directionality(
                      textDirection: TextDirection.ltr,
                      child: Container(

                        child: DataTable(
                            columns: [
                              DataColumn(
                                label: Text('ردیف'),
                              ),
                              DataColumn(
                                label: Text('PH'),
                              ),
                              DataColumn(label: Text('oxygen'),),
                              DataColumn(label: Text('temperature'),),

                            ],
                            rows: _models.asMap().entries.map((e) {
                              return  DataRow(cells: [
                                DataCell(Text(e.key.toString())),
                                DataCell(Text(e.value.ph.toString())),
                                DataCell(Text(e.value.oxygen.toString())),
                                DataCell(Text(e.value.temperature.toString())),

                              ]);
                            }).toList()),
                      ),
                    )*/
                    Row(
                      children: [
                        Expanded(child: Container(
                          height: MediaQuery.of(context).size.height*0.20,
                          decoration: BoxDecoration (
                            color: "ffffc9".toColor(),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          padding: EdgeInsets.all(3.w),
                          child:Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("assets/images/Layer 1.png",height: 30,),
                                  Text("pH",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                                ],
                              ),
                              Expanded(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("${model.ph}",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold))
                                ],
                              ))
                            ],
                          ) ,
                          
                        )),
                        SizedBox(width: 8,),
                        Expanded(child: Container(
                          height: MediaQuery.of(context).size.height*0.20,
                          decoration: BoxDecoration (
                            color: "e8ffea".toColor(),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          padding: EdgeInsets.all(3.w),
                          child:Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("assets/images/Layer 2.png",height: 30,),
                                  Text("اکسیژن",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                                ],
                              ),
                              Expanded(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("${model.oxygen}",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold)),
                                      Text("mg/I",style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold)),
                                    ],
                                  )
                                ],
                              ))
                            ],
                          ) ,

                        )),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(child: Container(
                          height: MediaQuery.of(context).size.height*0.20,
                          decoration: BoxDecoration (
                            color: "e6e6fe".toColor(),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          padding: EdgeInsets.all(3.w),
                          child:Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("assets/images/Layer 3.png",height: 30,),
                                  Text("شوری",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                                ],
                              ),
                              Expanded(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("${model.orp}",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold)),
                                      Text("ppt",style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold)),
                                    ],
                                  )
                                ],
                              ))
                            ],
                          ) ,

                        )),
                        SizedBox(width: 8,),
                        Expanded(child: Container(
                          height: MediaQuery.of(context).size.height*0.20,
                          decoration: BoxDecoration (
                            color: "ffe5e6".toColor(),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          padding: EdgeInsets.all(3.w),
                          child:Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("assets/images/Layer 4.png",height: 30,),
                                  Text("دما",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                                ],
                              ),
                              Expanded(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("${model.temperature}",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold)),
                                      Text("C",style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold)),
                                    ],
                                  )
                                ],
                              ))
                            ],
                          ) ,


                        )),

                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(16),
                        child: MaterialButton(onPressed: (){
                        },child: Text("ارسال اطلاعات به سمت سرور",style: TextStyle(color: Colors.white),),color: Colors.blue,),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
       if(_isLoading) Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
          ),
          child: Stack(
            children: [
              Align(
                child: CircularProgressIndicator(),
              )
            ],
          ),
        )
      ],
    );
  }
  _sendMessage() async {
    try {
      connection!.output
          .add(Uint8List.fromList(utf8.encode("m" +"\r")));
      await connection!.output.allSent;

      setState(() {
        messages.add(_Message(clientID, "m" ));
      });
    } catch (e) {
      setState(() {});
    }
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    for (var byte in data) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    }
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }
}
