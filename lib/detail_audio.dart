import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:music_app/app_colors.dart' as AppColors;
import 'package:music_app/audio_file.dart';

class DetailAudioPage extends StatefulWidget {
  const DetailAudioPage(
      {Key? key, required this.booksData, required this.index})
      : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final booksData;
  final int index;
  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  late AudioPlayer advancedPlayer;
  List _books = [];
  Future<void> readJson() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((s) {
      setState(() {
        _books = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advancedPlayer = AudioPlayer();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double sceenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.audioBluishBackground,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight / 3,
            child: Container(
              color: AppColors.audioBlueBackground,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    advancedPlayer.stop();
                    Navigator.of(context).pop();
                  }),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                )
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.2,
            left: 0,
            right: 0,
            height: screenHeight * 0.36,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Text(
                    widget.booksData[widget.index]['title'],
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Avenir"),
                  ),
                  Text(
                    widget.booksData[widget.index]['text'],
                    style: TextStyle(fontSize: 20),
                  ),
                  AudioFile(
                      advancedPlayer: advancedPlayer,
                      audioPath: widget.booksData[widget.index]['audio'])
                ],
                // AudioFile(advancedPlayer: advancedPlayer);
              ),
            ),
          ),
          Positioned(
              top: screenHeight * 0.12,
              left: (sceenWidth - 150) / 2,
              right: (sceenWidth - 150) / 2,
              height: screenHeight * 0.16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white, width: 5),
                        image: DecorationImage(
                            image: AssetImage(
                                widget.booksData[widget.index]['img']),
                            fit: BoxFit.fitHeight)),
                  ),
                ),
              )),
          // SizedBox(height: 20,),
          Positioned(
            top: screenHeight * 0.6,
            child: const Text(
              "Add to Play list",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
              top: screenHeight * 0.65,
              // width: ,
              left:  -20,
              right: 0,
              child: SizedBox(
                height: 200,
                width: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // ignore: unnecessary_null_comparison
                    itemCount: _books == null ? 0 : _books.length,
                    itemBuilder: (_, i) {
                      return Container(
                        height: 102,
                        width: sceenWidth/3,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(_books[i]["img"]),
                              fit: BoxFit.fill,
                            )),
                      );
                    }),
              ))
        ],
      ),
    );
  }
}
