import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RadioApp(),
    );
  }
}

class RadioApp extends StatefulWidget {
  @override
  _RadioAppState createState() => _RadioAppState();
}

class _RadioAppState extends State<RadioApp> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  AudioPlayer _player;
  AudioCache cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          activeColor: Colors.red[100],
          inactiveColor: Colors.grey[350],
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
    };

    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };

    // cache.load("listen.m3u");
    /**
     * Audio player plugin does not support m3u file
     * Use mp3 instead
     */
    cache.load("intro.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.red[800],
              Colors.red[200],
            ])),
        child: Padding(
          padding: EdgeInsets.only(
            top: 40.0,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                  ),
                  child: Center(
                    child: Text(
                      "EMOG RADIO",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12.0,
                  ),
                  child: Center(
                    child: Text(
                      "Listen to our Preaching Messages",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Center(
                  child: Container(
                    width: 280.0,
                    height: 280.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200.0),
                        image: DecorationImage(
                          image: AssetImage("assets/logo2.png"),
                        )),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                    ),
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red[900],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                        bottomRight: Radius.circular(0.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Let's start by adding the controller
                        Container(
                          width: 500.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              slider(),
                              Text(
                                "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 30.0,
                              color: Colors.white,
                              onPressed: () {},
                              icon: Icon(
                                Icons.info,
                              ),
                            ),
                            IconButton(
                              iconSize: 30.0,
                              color: Colors.white,
                              onPressed: () {},
                              icon: Icon(
                                Icons.message,
                              ),
                            ),
                            IconButton(
                              iconSize: 70.0,
                              color: Colors.white,
                              onPressed: () {
                                if (!playing) {
                                  cache.play("intro.mp3");
                                  /**
                                   * Always test audio player with a real device
                                   * Don't test with emulator or simulator it may not work
                                   */
                                  setState(() {
                                    playBtn = Icons.pause;
                                    playing = true;
                                  });
                                } else {
                                  _player.pause();
                                  setState(() {
                                    playBtn = Icons.play_arrow;
                                    playing = false;
                                  });
                                }
                              },
                              icon: Icon(
                                playBtn,
                              ),
                            ),
                            IconButton(
                              iconSize: 30.0,
                              color: Colors.white,
                              onPressed: () {},
                              icon: Icon(
                                Icons.call,
                              ),
                            ),
                            IconButton(
                              iconSize: 30.0,
                              color: Colors.white,
                              onPressed: () {},
                              icon: Icon(
                                Icons.fiber_smart_record,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
