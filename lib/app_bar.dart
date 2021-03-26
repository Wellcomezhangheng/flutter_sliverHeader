import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {

  final double opacity;

  const AppBarWidget({Key? key, this.opacity = 0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _buildAppBar();
  }

  _buildAppBar() {
    return PreferredSize(
      child: AppBar(
        title: InkWell(
          child: Text('立即播放', style: TextStyle(color: Colors.black.withOpacity(opacity)),),
        ),
        backgroundColor: Colors.white.withOpacity(opacity),
      ),
      preferredSize: Size.fromHeight(kToolbarHeight),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
