import 'package:flutter/material.dart';
import 'package:flutter_app/pages/community_page.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/my_page.dart';
import 'package:flutter_app/pages/search_page.dart';




class TabNavigator extends StatefulWidget{




  @override
  _TabNavigatorState createState() => _TabNavigatorState();//通过箭头函数返回实例









}


//内部类
class _TabNavigatorState extends State<TabNavigator>{


  //定义controller
  final PageController _controller = PageController(
    initialPage: 0,
  );

  final _defaultColor = Colors.grey;//默认颜色
  final _activeColor = Colors.blue;//默认颜色

  int _currentIndex = 0;



  //
  _pageChanged(int index){
//    _currentIndex = index;

  setState(() {
    _currentIndex = index;
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









}