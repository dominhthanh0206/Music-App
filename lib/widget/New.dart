import 'package:flutter/material.dart';

import '../detail_audio.dart';
import 'package:music_app/app_colors.dart' as AppColors;
class New extends StatelessWidget {
  const New({
    Key? key,
    required this.books,
  }) : super(key: key);

  final List? books;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: books == null ? 0 : books!.length,
        itemBuilder: (_, i) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailAudioPage(booksData: books, index: i,)));
              },
              child: Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.tabVarViewColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          offset: Offset(0, 0),
                          color: Colors.grey.withOpacity(0.2),
                        )
                      ]),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          width: 90,
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(
                                    books![i]["img"]),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star,
                                    size: 24,
                                    color: AppColors.starColor),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  books![i]["rating"],
                                  style: TextStyle(
                                      color:
                                          AppColors.menu2Color),
                                ),
                              ],
                            ),
                            Text(
                              books![i]["title"],
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Avenir",
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              books![i]["text"],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Avenir",
                                  color:
                                      AppColors.subTitleText),
                            ),
                            Container(
                              width: 60,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(3),
                                color: AppColors.loveColor,
                              ),
                               child: Text(
                                "Love",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "Avenir",
                                    color: Colors.white),
                              ),
                              alignment: Alignment.center,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}