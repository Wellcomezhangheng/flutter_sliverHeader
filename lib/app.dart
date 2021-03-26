import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test1/app_bar.dart';
import 'package:flutter_test1/sliverPersisiten.dart';
import 'package:flutter_test1/sliver_delegate.dart';

class MyHomePage extends StatefulWidget {
  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<MyHomePage> {
  bool isPlay = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setupState();
  }
  late int random1;
  late int random2;
  late int random3;

List<Color> colors= [Colors.red, Colors.green, Colors.black];
  // 初始化
  void _setupState() {
    random1 = Random().nextInt(255);
    random2 = Random().nextInt(255);
    random3 = Random().nextInt(255);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildWidget(),
      floatingActionButton: new TextButton(onPressed: () {
        setState(() {
          isPlay = !isPlay;

        });
      }, child: Text('${isPlay? '播放':'暂停'}')),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _buildWidget() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: CustomScrollView(
        slivers: [
          MySliverPersistentHeader(
            isScroll: isPlay,
            delegate: MySliverDelegate(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {

              return Container(
                color: colors[index % 3],
                height: 300,
              );
            }, childCount: 10),
          ),
        ],
      ),
    );
  }
}
