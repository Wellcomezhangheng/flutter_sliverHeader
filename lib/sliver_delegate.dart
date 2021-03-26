import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MySliverDelegate extends SliverPersistentHeaderDelegate {
  
  double maxHeight = 264;
  double minHeight = 64;
  
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {

    print('shrinkOffset===$shrinkOffset');
    print('overlapsContent===$overlapsContent');
    
    if (shrinkOffset > (maxHeight - minHeight)) {
      return Container(
        alignment: Alignment.center,
        child: Text('立即播放'),
        color: Colors.red.withOpacity(0.3),
        width: double.infinity,
        height: double.infinity,
      );
    }  
    // TODO: implement build
    return Container(
      child: Image.asset(
        'assets/img_icon.jpg',
        fit: BoxFit.cover,
      ),
       width: double.infinity,
      height: double.infinity,
      color: Colors.white,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent {
    return maxHeight;
  }

  @override
  // TODO: implement minExtent
  double get minExtent {
    return minHeight;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }

}