/*
* Created by Connel Asikong on 07/04/2025
*
*/

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CbIntros extends StatefulWidget {
  const CbIntros({
    super.key,
    required this.images,
    required this.colors,
    required this.titles,
    required this.desc,
    required this.moveToNextScreen,
    required this.boxHeight,
    required this.appPadding,
    required this.boxColor,
    required this.titleContainer,
    required this.descContainer,
    this.onPageChanged,
    this.btnColor = Colors.orange,
    this.btnIconColor = Colors.white,
    this.btnIcon = Icons.arrow_forward_ios,
    this.indicatorColor = Colors.grey,
    this.indicatorActiveColor = Colors.white,
  });

  final List<String> images;
  final List<Color> colors;
  final Color boxColor;
  final Color btnColor;
  final Color btnIconColor;
  final Color indicatorColor;
  final Color indicatorActiveColor;
  final IconData btnIcon;
  final WidgetBuilder titleContainer;
  final List<String> titles;
  final WidgetBuilder descContainer;
  final List<String> desc;
  final double boxHeight;
  final double appPadding;
  final VoidCallback moveToNextScreen;
  final ValueChanged<int>? onPageChanged;

  @override
  State<CbIntros> createState() => _CbIntrosState();
}

class _CbIntrosState extends State<CbIntros> {
  final _controller = PageController();
  int currentIndex = 0;
  double phoneHeight = 0.0;
  double phoneWidth = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_pageListener);
  }

  void _pageListener() {
    setState(() {
      currentIndex = _controller.page!.round();
      widget.onPageChanged?.call(currentIndex);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_pageListener);
    _controller.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    phoneHeight = MediaQuery.of(context).size.height;
    phoneWidth = MediaQuery.of(context).size.width;
  }

  void _onIntroNext() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      currentIndex = _controller.page!.round();
    });
  }

  void _onIntroEnd() {
    widget.moveToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: phoneWidth,
        height: phoneHeight,
        color: widget.colors[currentIndex],
        child: PageView(
          controller: _controller,
          children: List.generate(
            widget.colors.length,
            (index) => Column(
                  children: [
                    Expanded(
                      child: Builder(
                            builder: (BuildContext context) {
                              if (currentIndex < widget.images.length) {
                                // Determine image type based on some logic (e.g., file extension)
                                final imagePath = widget.images[currentIndex];
                                if (imagePath.endsWith('.svg')) {
                                  return SvgPicture.asset(
                                    imagePath,
                                    fit: BoxFit.cover,
                                  );
                                } else if (imagePath.startsWith('http') ||
                                    imagePath.startsWith('https')) {
                                  return Image.network(
                                    imagePath,
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return Image.asset(
                                    imagePath,
                                    fit: BoxFit.cover,
                                  );
                                }
                              } else {
                                return Container(); // Or some default/error widget
                              }
                            },
                          )
                          .animate(delay: 1000.ms)
                          .fadeIn(delay: 500.ms, duration: 1000.ms),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: widget.appPadding,
                      ),
                      child: AnimatedSmoothIndicator(
                        activeIndex: currentIndex,
                        count: widget.images.length,
                        effect: ExpandingDotsEffect(
                          spacing: 8.0,
                          radius: 4.0,
                          dotWidth: 10.0,
                          dotHeight: 8.0,
                          dotColor: widget.indicatorColor,
                          paintStyle: PaintingStyle.fill,
                          activeDotColor: widget.indicatorActiveColor,
                        ), // your preferred effect
                        onDotClicked: (index) {},
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: widget.boxHeight,
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                bottom: 50,
                              ),
                              child: ClipPath(
                                clipper: SideCutClipper(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: widget.boxColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        widget.titleContainer(context),
                                        SizedBox(height: 2),
                                        Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: widget.descContainer(context),

                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 30,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: widget.btnColor,
                                  ),
                                  child: IconButton(
                                    onPressed:
                                        currentIndex !=
                                                (widget.images.length - 1)
                                            ? _onIntroNext
                                            : _onIntroEnd,
                                    icon: Icon(
                                      widget.btnIcon,
                                      color: widget.btnIconColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 45),
                  ],
                )
                .animate()
                .fadeIn(duration: 1000.ms)
                .slideX(begin: 1, end: 0, duration: 1000.ms),
          ),
        ),
      ),
    );
  }
}

class SideCutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // The guest's shape is a circle bounded by the guest rectangle.
    // So the guest's radius is half the guest width.
    final double r = size.width / 8;
    final Rect host = Rect.fromLTWH(0, 0, size.width, size.height);
    final notCenter = Offset(size.width / 2, size.height);
    final Rect guest = Rect.fromCircle(center: notCenter, radius: r);
    final Radius notchRadius = Radius.circular(r);

    const double s1 = 15.0;
    const double s2 = 1.0;

    final double a = -r - s2 + host.center.dx - guest.center.dx;
    final double b = host.bottom - guest.center.dy;

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA) * -1;
    final double p2yB = math.sqrt(r * r - p2xB * p2xB) * -1;

    final List<Offset> p = List<Offset>.filled(6, Offset.zero);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) {
      p[i] += guest.center;
    }

    // Use the calculated points to draw out a path object.
    final Path path = Path()..moveTo(host.left, host.top);

    path
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(p[5].dx, p[5].dy)
      ..quadraticBezierTo(p[4].dx, p[4].dy, p[3].dx, p[3].dy)
      ..arcToPoint(p[2], radius: notchRadius, clockwise: false)
      ..quadraticBezierTo(p[1].dx, p[1].dy, p[0].dx, p[0].dy)
      ..lineTo(host.left, host.bottom);

    return path..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
