import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';


class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final String audioPath;
  const AudioFile({Key? key, required this.advancedPlayer, required this.audioPath}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = Duration();
  Duration _posision = Duration();
  // final String path =
  //     'https://data.chiasenhac.com/down2/2254/3/2253250-965196f4/128/Vi%20Me%20Anh%20Bat%20Chia%20Tay%20-%20Miu%20Le_%20Karik_.mp3';
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;
  bool isRepeat = false;
  Color? color;
  final List<IconData> _icon = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    widget.advancedPlayer.onPositionChanged.listen((p) {
      setState(() {
        _posision = p;
      });
    });
    widget.advancedPlayer.setSourceUrl(widget.audioPath);
    widget.advancedPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _posision = Duration(seconds: 0);
        
        if(isRepeat==true){
          isPlaying = true;
        }
        else{
          isPlaying = false;
          isRepeat = false; 
        }
      });
    });
  }

  Widget btnStart() {
    return IconButton(
      onPressed: () {
        if (isPlaying == false) {
          widget.advancedPlayer.play(UrlSource(widget.audioPath));
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          widget.advancedPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
      icon: isPlaying == false
          ? Icon(_icon[0], size: 35, color: Colors.blue)
          : Icon(_icon[1], size: 35),
      color: Colors.blue,
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.red,
        inactiveColor: Colors.grey,
        value: _posision.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        });
  }

  Widget btnFast() {
    return IconButton(
        onPressed: () {
          widget.advancedPlayer.setPlaybackRate(1.5);
        },
        icon: const ImageIcon(
          AssetImage('img/forward.png'),
          size: 15,
          color: Colors.black,
        ));
  }

  Widget btnSlow() {
    return IconButton(
        onPressed: () {
          widget.advancedPlayer.setPlaybackRate(0.5);
          // print(s);
        },
        icon: const ImageIcon(
          AssetImage('img/backword.png'),
          size: 15,
          color: Colors.black,
        ));
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer.seek(newDuration);
  }

  Widget loadAsset() {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            btnRepeat(),
            btnSlow(),
            btnStart(),
            btnFast(),
            btnLoop(),
          ]),
    );
  }

  Widget btnRepeat() {
    return IconButton(
        onPressed: () {
          if(isRepeat==false){
            widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
            setState(() {
              isRepeat=true;
              color = Colors.blue;
            });
          }
          else if(isRepeat == true){
            widget.advancedPlayer.setReleaseMode(ReleaseMode.release);
            color = Colors.black;
            isRepeat = false; 
          }
        },
        icon: ImageIcon(
          const AssetImage('img/repeat.png'),
          size: 15,
          color: color
        ));
  }

  Widget btnLoop() {
    return IconButton(
        onPressed: () {},
        icon: const ImageIcon(
          AssetImage('img/loop.png'),
          size: 15,
          color: Colors.black,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            _posision.toString().split(".")[0],
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            _duration.toString().split(".")[0],
            style: const TextStyle(fontSize: 16),
          )
        ]),
      ),
      slider(),
      loadAsset(),
    ]);
  }
}
