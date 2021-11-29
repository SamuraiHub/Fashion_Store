import 'dart:ui';

import 'package:flutter/material.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class WidgetPageViewHeader extends StatefulWidget {
  final Function(int index) notifyParent;
  WidgetPageViewHeader({Key? key, required this.notifyParent})
      : super(key: key);

  @override
  _WidgetPageViewHeaderState createState() => _WidgetPageViewHeaderState();
}

class _WidgetPageViewHeaderState extends State<WidgetPageViewHeader> {
  final listImageHeader = [
    'images/header_1.jpg',
    'images/header_2.jpg',
    'images/header_3.jpg',
    'images/header_4.jpg',
  ];
  int _indexHeader = 0;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var heightImage = mediaQuery.size.height / 1.5;
    return Container(
      height: heightImage,
      child: Stack(
        children: <Widget>[
          PageView.builder(
            scrollBehavior: AppScrollBehavior(),
            itemBuilder: (context, index) {
              return Image.asset(
                listImageHeader[index],
                fit: BoxFit.cover,
              );
            },
            itemCount: listImageHeader.length,
            onPageChanged: (index) {
              setState(() {
                _indexHeader = index;
                widget.notifyParent(index);
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              top: mediaQuery.size.height / 1.9,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < listImageHeader.length; i++)
                  if (i == _indexHeader) circleBar(true) else circleBar(false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: isActive ? 16 : 12,
      width: isActive ? 16 : 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: isActive ? Border.all(color: Colors.white) : null,
      ),
      padding: EdgeInsets.all(isActive ? 4.0 : 0.0),
      child: Container(
        width: isActive ? 8 : 16,
        height: isActive ? 8 : 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white,
        ),
      ),
    );
  }
}
