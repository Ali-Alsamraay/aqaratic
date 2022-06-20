import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
 

Future showAlert(String msg, BuildContext context) {
  // flutter defined function
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        'تنبيه',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red),
      ),
      content: Text(
        msg,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pop(
                context); // dismisses only the dialog and returns nothing
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black54),
          ),
          child: const Align(alignment: Alignment.center, child: Text('موافق')),
        ),
      ],
    ),
  );
}

final spinkit = SpinKitFadingCube(
  itemBuilder: (context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? const Color(0xffd2f5e3) : const Color(0xff75cfb8),
      ),
    );
  },
);

// write(String text, String contactName) async {
//   final Directory directory = await getApplicationDocumentsDirectory();
//   final File file = File('${directory.path}/$contactName.vcf');
//   await file.writeAsString(text);
//   Share.shareFiles(['${directory.path}/$contactName.vcf']);
// }

extension nil on String {
  bool isNullOrEmpty() {
    if (this == null || this.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool isNotNullOrEmpty() {
    if (this == null || this.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
