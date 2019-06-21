import 'package:flutter/material.dart';

//import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'dart:async';

//import 'package:qr_flutter/qr_flutter.dart';

import 'package:qrscan/qrscan.dart' as scanner;
//import 'package:Qrscan/Qrscan.dart';


class MyPage extends  StatefulWidget{


  @override
  _MyPageState createState() => _MyPageState();



}


class _MyPageState extends State<MyPage>{



  String barcode = "";


  //条形码
//  Future scan() async {
//    try {
//      String barcode = await BarcodeScanner.scan();
//      setState(() {
//        return this.barcode = barcode;
//      });
//    } on PlatformException catch (e) {
//      if (e.code == BarcodeScanner.CameraAccessDenied) {
//        setState(() {
//          return this.barcode = 'The user did not grant the camera permission!';
//        });
//      } else {
//        setState(() {
//          return this.barcode = 'Unknown error: $e';
//        });
//      }
//    } on FormatException{
//      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
//    } catch (e) {
//      setState(() => this.barcode = 'Unknown error: $e');
//    }
//  }



  //扫描二维码
  Future scan() async {
    try {
      String barcode = await scanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == scanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }


  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      print('按下了扫描按钮');

      //扫描功能


    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text('我 $barcode'),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: scan,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      )
    );
  }



}