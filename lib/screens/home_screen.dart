import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<int> minuteList = [1, 2, 3, 5, 10, 15, 20, 25, 30, 35, 40];
  static const int totalRound = 2;
  static const int totalGoal = 2;

  int originSeconds = 25;
  int totalSeconds = 25;
  bool isRunning = false;
  int currentRound = 0;
  int currentGoal = 0;
  bool isMissionSuccess = false;
  Timer? timer;

  void reset() {
    timer?.cancel();
    setState(() {
      isMissionSuccess = false;
      isRunning = false;
      currentRound = 0;
      currentGoal = 0;
      totalSeconds = originSeconds;
    });
  }

  void onTick(Timer timer) {
    setState(() {
      if (totalSeconds == 0) {
        timer.cancel();
        isRunning = false;
        totalSeconds = originSeconds;
        currentRound = currentRound + 1;
        if (currentRound == totalRound) {
          currentRound = 0;
          currentGoal = currentGoal + 1;
          if (currentGoal == totalGoal) {
            isMissionSuccess = true;
          }
        }
      } else {
        totalSeconds = totalSeconds - 1;
      }
    });
  }

  void onStartPressed() {
    if (isMissionSuccess) {
      return;
    }

    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onSelectSeconds(int seconds) {
    timer?.cancel();
    setState(() {
      isRunning = false;
      totalSeconds = seconds;
      originSeconds = seconds;
    });
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  String formatMinutes(int seconds) {
    var duration = Duration(seconds: seconds);
    var digitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return digitMinutes;
  }

  String formatSeconds(int seconds) {
    var duration = Duration(seconds: seconds);
    var digitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return digitSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Text(
                'POMOTIMER',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Transform.translate(
                      offset: const Offset(10, -10),
                      child: Container(
                        alignment: Alignment.center,
                        width: 110,
                        height: 140,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.4),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                5,
                              ),
                            )),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(5, -5),
                      child: Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 150,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.6),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                5,
                              ),
                            )),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 130,
                      height: 160,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              5,
                            ),
                          )),
                      child: Text(
                        formatMinutes(totalSeconds),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 70,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  width: 30,
                  child: const Text(
                    ':',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Transform.translate(
                      offset: const Offset(10, -10),
                      child: Container(
                        alignment: Alignment.center,
                        width: 110,
                        height: 140,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.4),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                5,
                              ),
                            )),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(5, -5),
                      child: Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 150,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.6),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                5,
                              ),
                            )),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 130,
                      height: 160,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              5,
                            ),
                          )),
                      child: Text(
                        formatSeconds(totalSeconds),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 70,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Colors.transparent,
                    Colors.black,
                    Colors.transparent
                  ],
                  stops: [0.0, 0.5, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: minuteList.map((item) {
                    return GestureDetector(
                      onTap: () {
                        onSelectSeconds(item);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        width: 60,
                        height: 45,
                        decoration: BoxDecoration(
                          color: item == originSeconds
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              5,
                            ),
                          ),
                          border: Border.all(
                            color: Colors.white,
                            width: item == originSeconds ? 0 : 3,
                          ),
                        ),
                        child: Text(
                          '$item',
                          style: TextStyle(
                            color: item == originSeconds
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 230,
                    alignment: Alignment.center,
                    child: IconButton(
                      iconSize: 100,
                      icon: isRunning
                          ? const Icon(
                              Icons.pause_circle_outline,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                ),
                              ],
                            )
                          : const Icon(
                              Icons.play_circle_outline,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                      onPressed: isRunning ? onPausePressed : onStartPressed,
                      color: const Color.fromRGBO(255, 255, 255, 0.9),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 230,
                    alignment: Alignment.center,
                    child: IconButton(
                      iconSize: 50,
                      icon: const Icon(
                        Icons.refresh,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      onPressed: reset,
                      color: const Color.fromRGBO(255, 255, 255, 0.9),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 20),
              height: 50,
              child: Text(
                isMissionSuccess
                    ? 'Mission Complete!\nTap Reset Button for restarting now.'
                    : '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          '$currentRound/$totalRound',
                          style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'ROUND',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          '$currentGoal/$totalGoal',
                          style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'GOAL',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
