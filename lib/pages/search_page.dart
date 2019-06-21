import 'package:flutter/material.dart';
import 'package:flutter_app/widget/search_bar.dart';

import 'package:qr_flutter/qr_flutter.dart';


class SearchPage extends  StatefulWidget{


  @override
  _SearchPageState createState() => _SearchPageState();



}


class _SearchPageState extends State<SearchPage>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SearchBar(
            searchBarType: SearchBarType.normal,
            hideLeft: true,
            defaultText: '哈哈',
            hint: '123',
            leftButtonClick: (){
              Navigator.pop(context);
            },
            onChanged: _onTextChange,
          ),
          InkWell(
            onTap: (){
              //搜索功能




            },
          )
        ],
//        child: Text('123'),
//        child:QrImage(
//          data: '这是需要生成的二维码数据',
//          size: 100.0,
//          onError: (ex){
//            print("[QR] ERROR - $ex");
//          },
        )

//      ),

    );
  }


  _onTextChange(String text){

  }



}