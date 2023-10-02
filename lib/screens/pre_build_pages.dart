import 'package:flutter/material.dart';
import 'package:quran_app/models/page.dart';

class PreBuildPages extends StatefulWidget {
  const PreBuildPages({
    Key? key,
    required this.pages,
  }) : super(key: key);
  final List<QPage> pages;
  @override
  State<PreBuildPages> createState() => _PreBuildPagesState();
}

class _PreBuildPagesState extends State<PreBuildPages> {
  int pageNumber = 1;
  bool isPined = false;
  List<Widget> qPages = [];

  int getPreviousIndex() => pageNumber - 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: GestureDetector(
          // onScaleUpdate: (d) {
          //   setState(() {
          //     scale = d.scale;
          //   });
          // print(d.scale);
          // },
          child: PageView(
            physics: isPined ? const NeverScrollableScrollPhysics() : null,
            onPageChanged: (index) async {
              if (index > getPreviousIndex()) {
                pageNumber++;
              } else {
                pageNumber--;
              }
              setState(() {});

              if (qPages.length < pageNumber + 1) {
                QPage page = QPage();
                page.getByPage(pageNumber + 1);
                // qPages.add(QPageScreen(
                //   pageNumber: pageNumber + 1,
                //   page: page.suras,
                //   // scale: scale,
                // ));
              }
              print(qPages.length);

              // await widget.pages[1].getByPage(pageNumber);
              // await widget.pages[2].getByPage(pageNumber + 1);

              // getData();
            },
            children: qPages,
          ),
        ),
      ),
    );
  }
}
