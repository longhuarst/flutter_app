import 'package:flutter/material.dart';
import 'package:flutter_app/pages/community_page.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/my_page.dart';
import 'package:flutter_app/pages/search_page.dart';
import 'package:socket_flutter_plugin/socket_flutter_plugin.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

import 'dart:io';




//import  'package:flutter_socket_io/flutter_socket_io.dart';



class TabNavigator extends StatefulWidget{




  @override
  _TabNavigatorState createState() => _TabNavigatorState();//通过箭头函数返回实例









}


//内部类
class _TabNavigatorState extends State<TabNavigator>{


  String _platformVersion = 'Unknown';

  //定义controller
  final PageController _controller = PageController(
    initialPage: 0,
  );

  final _defaultColor = Colors.grey;//默认颜色
  final _activeColor = Colors.blue;//默认颜色

  int _currentIndex = 0;



  bool isConnected = false;


  //
  _pageChanged(int index){
//    _currentIndex = index;

  setState(() {

    print('init');
    _currentIndex = index;

//    socket();

    _connect('192.168.31.64',9006);
    initPlatformState();
  });
    print(index);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: _pageChanged,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          CommunityPage(),
          MyPage(),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index){
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },

          type: BottomNavigationBarType.fixed,//不管是否被选中tab都会显示文字
          items:
      [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: _defaultColor,//默认颜色
          ),
          activeIcon: Icon(
            Icons.home,
              color: _activeColor,//激活颜色
          ),
          title: Text('首页',style:TextStyle(
            color: _currentIndex != 0 ? _defaultColor : _activeColor
          ))
        ),

        BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _defaultColor,//默认颜色
            ),
            activeIcon: Icon(
              Icons.search,
              color: _activeColor,//激活颜色
            ),
            title: Text('搜索',style:TextStyle(
                color: _currentIndex != 1 ? _defaultColor : _activeColor
            ))
        ),


        BottomNavigationBarItem(
            icon: Icon(
              Icons.keyboard,
              color: _defaultColor,//默认颜色
            ),
            activeIcon: Icon(
              Icons.keyboard,
              color: _activeColor,//激活颜色
            ),
            title: Text('社区',style:TextStyle(
                color: _currentIndex != 2 ? _defaultColor : _activeColor
            ))
        ),





        BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _defaultColor,//默认颜色
            ),
            activeIcon: Icon(
              Icons.person,
              color: _activeColor,//激活颜色
            ),
            title: Text('我',style:TextStyle(
                color: _currentIndex != 3 ? _defaultColor : _activeColor
            ))
        ),

      ]
      ),
    );
  }







//  Future<void> connect







  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    try {
      SocketFlutterPlugin myIO = new SocketFlutterPlugin();
      myIO.socket("http://192.168.31.64:9006");
      myIO.connect();
      String jsonData =
          '{"content":"test"}';
      myIO.emit("chat",jsonData);
      myIO.on("chat",(data){
        debugPrint(data.toString());
      });
      print('complete');
    } on PlatformException {

      print('Failed to get platform version.');
      _platformVersion = 'Failed to get platform version.';
    }
  }



//  Future<void> socket() async {
//    try{
//
//
//      Socket.connect("192.168.31.64", 9006);
//
//    }
//  }


  Socket _socket;

  Future<Socket> _connect(String ip, int port) async{
    if(!isConnected) {
      print('connect...');
        try {
          _socket = await Socket.connect(ip, port, timeout: Duration(seconds: 5),);

          isConnected = true;
          print('---');
          _socket.writeln('hellow');
          _socket.listen(_onData, onError: _onError, onDone: _onDone);

          print('exit');
        }catch(e){
          if(e is SocketException){
            _onTimeout();
          }else{
            print("error : $e");
          }
        }
    }
    return _socket;
  }


  _onData(List<int> data){
    print('ondata');
  }



  _onError(Object error){
    print('error');

    isConnected = false;
  }

  _onDone(){
    print('done');

  }


  _onTimeout(){
    print('timeout');
    isConnected = false;
  }





}