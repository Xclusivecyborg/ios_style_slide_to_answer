import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_style_slide_to_answer/custom_button.dart';
import 'package:ios_style_slide_to_answer/shimmer_text.dart';

class SlideToAnserView extends StatelessWidget {
  const SlideToAnserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey.shade600,
                    Colors.blueGrey.shade700,
                    Colors.blueGrey.shade800,
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            right: 20,
            child: SafeArea(
              child: Icon(
                CupertinoIcons.info,
                color: Colors.grey,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Text(
                    'mobile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Flutter Benders',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SlideToAnswerSwitcher(),
        ],
      ),
    );
  }
}

class SlideToAnswerSwitcher extends StatefulWidget {
  const SlideToAnswerSwitcher({super.key});

  @override
  State<SlideToAnswerSwitcher> createState() => _SlideToAnswerSwitcherState();
}

class _SlideToAnswerSwitcherState extends State<SlideToAnswerSwitcher> {
  final double _height = 80;
  double _width = 400;
  final double _padding = 5;
  late double _initialWidth;
  bool _hasAnswered = false;

  @override
  void initState() {
    super.initState();
    _initialWidth = _width;
  }

  final List<(String, IconData)> _unAnsweredButtons = [
    ('Message', CupertinoIcons.chat_bubble_fill),
    ('Voicemail', CupertinoIcons.recordingtape)
  ];

  final List<(String, IconData)> _answeredButtons = [
    ('Speaker', CupertinoIcons.speaker_3_fill),
    ('FaceTime', CupertinoIcons.video_camera_solid),
    ('Mute', CupertinoIcons.mic_slash_fill),
    ('Add', CupertinoIcons.person_crop_circle_badge_plus),
    ('End', CupertinoIcons.phone_down_fill),
    ('Keypad', CupertinoIcons.circle_grid_3x3_fill),
  ];

  @override
  Widget build(BuildContext context) {
    double buttonWidth = _initialWidth / 6;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: _hasAnswered
          ? Align(
              key: const ValueKey('answered'),
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Wrap(
                  children: List.generate(
                    _answeredButtons.length,
                    (index) {
                      var (text, icon) = _answeredButtons[index];
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CustomButton(
                          buttonColor: index == _answeredButtons.length - 2
                              ? Colors.red
                              : null,
                          onTap: () {
                            if (index == _answeredButtons.length - 2) {
                              _hasAnswered = false;
                              _width = _initialWidth;
                              setState(() {});
                            }
                          },
                          padding: 20,
                          text: text,
                          icon: icon,
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          : Align(
              key: const ValueKey('unanswered'),
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        _unAnsweredButtons.length,
                        (index) {
                          var (text, icon) = _unAnsweredButtons[index];
                          return CustomButton(
                            text: text,
                            icon: icon,
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(_padding),
                      width: _width,
                      height: _height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white.withOpacity(0.3),
                      ),
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 60),
                      child: GestureDetector(
                        onHorizontalDragEnd: _onDragEnd,
                        onHorizontalDragUpdate: _onDragUpdate,
                        child: Stack(
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: ShimmerText(
                                text: 'Slide to Answer',
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              width: buttonWidth,
                              child: const Icon(
                                CupertinoIcons.phone_fill,
                                color: Colors.green,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _onDragUpdate(DragUpdateDetails details) {
    double buttonWidth = _initialWidth / 6;
    double threshHold = buttonWidth + (_padding * 2);

    var distance = details.delta.distance;

    if (details.delta.dx > 0) {
      _width = max(
        _width - distance,
        threshHold,
      );
    } else {
      _width = min(
        _width + details.delta.distance,
        _initialWidth,
      );
    }
    setState(() {});
  }

  void _onDragEnd(DragEndDetails details) {
    var threshold = (_initialWidth / 6) + (_padding * 2);
    if (_width >= _initialWidth) return;
    if (_width == threshold) {
      _hasAnswered = true;
    } else {
      _width = _initialWidth;
    }
    setState(() {});
  }
}
