import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Text title;
  final Widget image;
  final AppBar appBar;
  final Widget leading;
  final List<Widget> widgets;
  final Widget bottom;

  /// you can add more fields that meet your needs

  const BaseAppBar({Key key,
    this.title,
    this.appBar,
    this.widgets,
    this.image,
    this.leading,
    this.bottom,
    this.backgroundColor
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var newtitle;
    if (title !=null){
      newtitle = title;
    }else{
      newtitle = image;
    }
    return  AppBar(
      elevation: 0.0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: backgroundColor !=null ? backgroundColor : Colors.white,
      title: Container(
        margin: EdgeInsets.only(top:5),
        // color: Colors.red,
        child: newtitle,
      ),
      leading: leading,
      actions: widgets,
      bottom:bottom
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}