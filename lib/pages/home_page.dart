import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';


import 'package:cached_network_image/cached_network_image.dart';
//import '';

//import '';

const APPBAR_SCROLL_OFFSET = 100;//最大滚动距离

class HomePage extends  StatefulWidget{


  @override
  _HomePageState createState() => _HomePageState();



}


class _HomePageState extends State<HomePage>{

  List _imageUrls = [
    //图片的url
    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg',

  ];


  double appBarAlpha = 0; //appbar透明度

  _onScroll(offset){
//    print(offset);

    double alpha = offset / APPBAR_SCROLL_OFFSET;

    if (alpha<0)
      alpha = 0;
    else if (alpha > 1)
      alpha = 1;

    setState(() {
      appBarAlpha = alpha;
    });

    
    print(appBarAlpha);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(//移除顶部白条
              removeTop: true,//移除顶部
              context: context,
              child: NotificationListener(
                  onNotification: (scrollNotification){
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0){//下下搜索为0
                      //滚动且是列表滚动的时候
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                  },
                  child: ListView(
                    children: <Widget>[
                      Container(
                          height: 160,//bander的高度

                          child:Swiper(itemCount:_imageUrls.length,
                            autoplay:true,//自动播放
                            itemBuilder:(BuildContext context, int index){
                            return new CachedNetworkImage(
//                              placeholder: new CircularProgressIndicator(),
                              imageUrl:_imageUrls[index],
                              fit: BoxFit.fill,
//                              placeholder: new CircularProgressIndicator(
//                                value: null,
//                                backgroundColor: Colors.grey,
//                              ),

                            );
//                              return Image.network(
//                                _imageUrls[index],
//                                fit: BoxFit.fill,
//                              );
                            },
                            pagination:SwiperPagination(),//添加指示器),
                          )
                      ),
                      Container(
                        height: 800,
                        child: ListTile(
                          title: Text('哈哈'),
                        ),
                      ),
                    ],
                  ))
          ),

          Opacity(
              opacity: appBarAlpha,//透明度
              child: Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child:Center(
                  child: Padding(
                    padding: EdgeInsets.only(top:20),
                    child:Text('首页'),
                  ),

                )

              )
          )

        ],
      )
    );
  }



}