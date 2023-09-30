import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/models/bookmark.dart';
import 'package:quran_app/servises/provider.dart';
import '../models/aya.dart';
import '../models/tafseer.dart';
import '../servises/network.dart';
import '../shared/functionalty.dart';

class QPageScreen extends StatefulWidget {
  const QPageScreen({
    super.key,
    required this.pageNumber,
    required this.page,
    this.connectivityResult,
    this.bookmark,
    this.isPartScreen = false,
    required this.index,
    // required this.scale,
  });

  final ConnectivityResult? connectivityResult;
  final int pageNumber;
  final int index;
  final List<Sura> page;
  final Bookmark? bookmark;
  final bool isPartScreen;

  // final double scale;

  @override
  State<QPageScreen> createState() => _QPageScreenState();
}

class _QPageScreenState extends State<QPageScreen> {
  double scale = 1.0;

  bool isMarked(Bookmark? bookmark, int suraNo, int ayaNo) {
    if (bookmark != null &&
        bookmark.suraNo == suraNo &&
        bookmark.ayaNo == ayaNo) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleUpdate: (d) {
        setState(() {
          scale = d.scale;
        });
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: widget.pageNumber % 2 == 0
              ? const LinearGradient(
                  colors: [
                    Color(0xffffedd9),
                    Color(0xfffff7eb),
                    Color(0xfffdfcfa),
                  ],
                )
              : const LinearGradient(
                  colors: [
                    Color(0xfffdfcfa),
                    Color(0xfffff7eb),
                    Color(0xffffedd9),
                  ],
                ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      getJozzName(widget.page.first.sura.first.jozz ?? 0),
                      style: const TextStyle(
                          fontSize: 18, fontFamily: 'Al-QuranAlKareem'),
                    ),
                    const Spacer(),
                    for (int i = 0; i < widget.page.length; i++) ...{
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8),
                        child: Text(
                          widget.page[i].suraNameAr ?? '',
                          style: const TextStyle(
                              fontSize: 18, fontFamily: 'Al-QuranAlKareem'),
                        ),
                      ),
                    }
                  ],
                ),
                for (int i = 0; i < widget.page.length; i++) ...{
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    child: Consumer<BookmarkProvider>(
                      builder: (context, provider, child) {
                        return Text.rich(
                          TextSpan(
                            children: [
                              for (int j = 0;
                                  j < widget.page[i].sura.length;
                                  j++) ...{
                                WidgetSpan(
                                  child: Visibility(
                                    visible: widget.page[i].sura[j].ayaNo == 1,
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          height: 60,
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                'images/head_of_surah.png',
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            widget.page[i].suraNameAr ?? '',
                                            style: const TextStyle(
                                                fontSize: 30,
                                                fontFamily: 'Al-QuranAlKareem'),
                                          ),
                                        ),
                                        Visibility(
                                            visible: widget.page[i].sura[j]
                                                        .suraNo !=
                                                    1 &&
                                                widget.page[i].sura[j].suraNo !=
                                                    9,
                                            child: const Text(
                                              'بسم الله الرحمن الرحيم',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.black,
                                                  fontFamily: 'HafsSmart'),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                TextSpan(
                                    recognizer: LongPressGestureRecognizer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                    )..onLongPress = () {
                                        Aya aya = widget.page[i].sura[j];
                                        onLongPress(context, provider,
                                            bookmark: Bookmark(
                                                widget.isPartScreen
                                                    ? aya.jozz ?? 0
                                                    : 0,
                                                widget.index,
                                                aya.suraNo ?? 1,
                                                aya.ayaNo ?? 1));
                                      },
                                    text: ' ${widget.page[i].sura[j].ayaText} ',
                                    style: TextStyle(
                                      backgroundColor: isMarked(
                                              getBookMark(
                                                  provider.bookmarks, 0),
                                              widget.page[i].sura[j].suraNo ??
                                                  1,
                                              widget.page[i].sura[j].ayaNo ?? 1)
                                          ? Colors.lightBlueAccent[100]
                                          : null,
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'HafsSmart',
                                    )),
                              },
                            ],
                          ),
                          textAlign: TextAlign.center,
                          textScaleFactor: scale,
                        );
                      },
                    ),
                  ),
                },
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.pageNumber.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Al-QuranAlKareem',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLongPress(
    BuildContext context,
    BookmarkProvider provider, {
    required Bookmark bookmark,
  }) async {
    print('book mark $bookmark');
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      provider.insertToBookmarks(context, bookmark: bookmark);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                        height: 44,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.bookmark,
                            ),
                            Text('حفظ التقدم')
                          ],
                        ),
                      ),
                    )),
                tafseerBody(bookmark.suraNo, bookmark.ayaNo),
              ],
            ),
          );
        });
  }

  Widget tafseerBody(
    int soraNo,
    int ayaNo,
  ) {
    if (widget.connectivityResult == ConnectivityResult.mobile ||
        widget.connectivityResult == ConnectivityResult.wifi ||
        widget.connectivityResult == ConnectivityResult.ethernet) {
      Future<Tafseer> tafseer = Network().fetchTafseer(context, soraNo, ayaNo);

      return FutureBuilder<Tafseer>(
          future: tafseer,
          builder: (context, snapshot) {
            return Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  snapshot.data?.text ?? "الرجاء لانتظار",
                  style: const TextStyle(
                    fontFamily: 'monospace',
                  ),
                ));
          });
    } else {
      return const SizedBox();
    }
  }
}
