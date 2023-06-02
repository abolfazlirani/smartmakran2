import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartmkran/app/pages/offilne/view.dart';
import 'package:smartmkran/gen/model/off.dart';

class OffStorageDialog extends StatelessWidget {
  OfflineSendedModel offlineSendedModel;

  OffStorageDialog(this.offlineSendedModel);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('ارسال اطلاعات به سمت سرور'),
      content: Text('اطلاعات مربوط به این قسمت در حافظه ذخیره شد.برای ارسال به سمت سرور لطفا به صفحه حافظه داخلی بروید'),
      actions: <Widget>[
        TextButton(
          child: Text('رفتن به صفحه حافظه داخلی'),
          onPressed: () {
            // TODO: Handle action 1
            // Add your logic here to navigate to the internal memory page
            Get.to(OffileStoragePage(),arguments:[offlineSendedModel.pound] );
          },
        ),
        TextButton(
          child: Text('انصراف'),
          onPressed: () {
            // TODO: Handle action 2
            // Add your logic here for canceling the operation
            Get.back();
          },
        ),
      ].reversed.toList(),
    );
  }
}

// To display the dialog, you can call it from your widget's build method like this:
// showDialog(
//   context: context,
//   builder: (BuildContext context) {
//     return MyDialog();
//   },
// );
