import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'dart:async';

class HeyCloudy extends StatefulWidget {
  @override
  _HeyCloudyState createState() => _HeyCloudyState();
}

class _HeyCloudyState extends State<HeyCloudy> {
  PageController pageController = PageController();
  int currentIndex = 0;
  Timer? _timer;

  final List<String> images = [
    'assets/images/card1.jpg',
    'assets/images/card2.jpg',
    'assets/images/card3.jpg',
    'assets/images/card4.jpg',
    'assets/images/card5.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (currentIndex < images.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }

      pageController.animateToPage(
        currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Stack
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 190,
                      child: Image.asset(
                        'assets/images/home-header.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 10,
                    child: Image.asset('assets/images/star.png',
                        width: 80, height: 80),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Icon(Icons.more_vert, size: 28, color: Colors.white),
                  ),
                  Positioned(
                    top: 51,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Image.asset('assets/images/cloud-header.png'),
                  ),
                ],
              ),
            ),

            // PageView
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: pageController,
                itemCount: images.length,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      // Background Image
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Title
                      Positioned(
                        top: 12,
                        left: 24,
                        child: Text(
                          "Stories that teach",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(blurRadius: 2, color: Colors.black)
                              ]),
                        ),
                      ),

                      // Play Button (SVG)
                      Positioned(
                        top: 50,
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            print("Play tapped on index $index");
                          },
                          child: SvgPicture.asset(
                            'assets/icons/ic_play.svg',
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Dot Indicator
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: DotsIndicator(
                dotsCount: images.length,
                position: currentIndex.toDouble(),
                decorator: DotsDecorator(
                  activeColor: Colors.black,
                  size: const Size.square(8.0),
                  activeSize: const Size(18.0, 8.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),

// Story Cards Section (Horizontal Scroll)
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                    radius: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Everyday Stories',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),

            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(images[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/icons/ic_play.svg',
                              height: 30,
                              width: 30,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: 100,
                          child: Text(
                            index == 0
                                ? 'The Thirsty Crow'
                                : index == 1
                                    ? 'The Happiest Of All'
                                    : 'The Brave One',
                            style: TextStyle(fontSize: 12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
