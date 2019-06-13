import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_samples/carousel/CustomPageView.dart';

class Carousel extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Carousel> {
  PageController _pageController =
      PageController(initialPage: 1, viewportFraction: 0.9);
  int _currentIndex = 1;
  List<String> _images = [
    'images/1.png',
    'images/2.png',
    'images/3.png',
    'images/4.png',
    'images/5.png',
    'images/6.png',
    'images/7.png',
    'images/8.png',
    'images/9.png',
  ];
  Timer _timer;

  @override
  void initState() {
    print(_images.asMap());
    if (_images.length > 0) {
      _setTimer();
    }
    super.initState();
  }

//设置定时器
  _setTimer() {
    _timer = Timer.periodic(Duration(seconds: 4), (_) {
      _pageController.animateToPage(_currentIndex + 1,
          duration: Duration(milliseconds: 400), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    List addedImages = [];
    if (_images.length > 0) {
      addedImages
        ..add(_images[_images.length - 1])
        ..addAll(_images)
        ..add(_images[0]);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Carousel'),
        centerTitle: true,
      ),
      body: AspectRatio(
        aspectRatio: 2.5,
        child: Stack(
          children: [
            NotificationListener(
              onNotification: (ScrollNotification notification) {
                if (notification.depth == 0 &&
                    notification is ScrollStartNotification) {
                  if (notification.dragDetails != null) {
                    _timer.cancel();
                  }
                } else if (notification is ScrollEndNotification) {
                  _timer.cancel();
                  _setTimer();
                }
              },
              child: _images.length > 0
                  ? CustomPageView(
                      physics: BouncingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (page) {
                        int newIndex;
                        if (page == addedImages.length - 1) {
                          newIndex = 1;
                          _pageController.jumpToPage(newIndex);
                        } else if (page == 0) {
                          newIndex = addedImages.length - 2;
                          _pageController.jumpToPage(newIndex);
                        } else {
                          newIndex = page;
                        }
                        setState(() {
                          _currentIndex = newIndex;
                        });
                      },
                      children: addedImages
                          .map((item) => Container(
                                margin: EdgeInsets.all(10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Image.asset(
                                    item,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ))
                          .toList(),
                    )
                  : Container(),
            ),
            Positioned(
              bottom: 15.0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _images
                    .asMap()
                    .map((i, v) => MapEntry(
                        i,
                        Container(
                          width: 6.0,
                          height: 6.0,
                          margin: EdgeInsets.only(left: 2.0, right: 2.0),
                          decoration: ShapeDecoration(
                              color: _currentIndex == i + 1
                                  ? Colors.red
                                  : Colors.white,
                              shape: CircleBorder()),
                        )))
                    .values
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
