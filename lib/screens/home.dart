import 'package:flutter/material.dart';
import 'package:quran_app/models/page.dart';
import 'package:quran_app/widgets/quran_page.dart';
import '../models/aya.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.page}) : super(key: key);
  final QPage page;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageNumber = 1;
  List<Sura> page = [];
  bool isPined = false;
  void getData() {
    page = widget.page.suras;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onScaleUpdate: (d) {
              setState(() {
                scale = d.scale;
              });
              print(d.scale);
            },
            child: PageView.builder(
              physics: isPined ? const NeverScrollableScrollPhysics() : null,
              onPageChanged: (index) async {
                if (index > getPreviousIndex()) {
                  pageNumber++;
                } else {
                  pageNumber--;
                }
                await widget.page.getByPage(pageNumber);
                setState(() {});
              },
              itemBuilder: (context, index) {
                return QPageScreen(
                  pageNumber: pageNumber,
                  page: widget.page.suras,
                  index: index,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  int getPreviousIndex() => pageNumber - 1;
}
