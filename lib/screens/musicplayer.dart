import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {

  bool isPlaying = false;
  double value= 0;
  //instance of the music player
  final player = AudioPlayer();

  //seting duration

  Duration? duration = Duration(seconds: 0);

  //initiate the music into the player
  void initPlayer() async{
    await player.setSource(AssetSource("music.mp3"));
    duration = await player.getDuration();
  }
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.transparent,
      //   title: Text("Muzic"),
      //     centerTitle: true,
      //
      // ),
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/pac.jpg"),
                fit: BoxFit.cover
              )
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(
                color: Colors.black54,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset("assets/pac.jpg", width: 250,),
              ),
              SizedBox(height: 20,),
              Text(
                "Summer Vibes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36.0,
                  letterSpacing: 6
                ),
              ),
              SizedBox(height: 56,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${(value / 60).floor()}:${(value % 60).floor()}", style: TextStyle(color: Colors.white),),
                  Slider.adaptive(
                    min: 0.0,
                    max: duration!.inSeconds.toDouble(),
                    value: value, onChanged: (value){}, activeColor: Colors.white,),
                  Text("${duration?.inMinutes} : ${duration?.inSeconds}", style: TextStyle(color: Colors.white),),
                ],
              ),
              
              SizedBox(height: 30.0,),
              

              Container(
                width: 60,
              height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.black87,
                  border: Border.all(color: Colors.pink)
                ),
                child: InkWell(
                  onTap: () async{
                    await player.resume();
                    player.onPositionChanged.listen((position) {
                      setState(() {
                        value = position.inSeconds.toDouble();
                      });
                    });
                  },
                  child: Icon(Icons.play_arrow, color: Colors.white,),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
