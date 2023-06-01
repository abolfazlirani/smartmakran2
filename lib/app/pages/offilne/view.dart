import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartmkran/app/pages/offilne/logic.dart';

class OffileStoragePage extends StatefulWidget {
  const OffileStoragePage({Key? key}) : super(key: key);

  @override
  State<OffileStoragePage> createState() => _OffileStoragePageState();
}

class _OffileStoragePageState extends State<OffileStoragePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfflineSendLogic>(
      init: OfflineSendLogic(),
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("مدیریت رکوست ها"),
          ),

        );
      }
    );
  }
}
