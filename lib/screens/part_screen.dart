import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/models/page.dart';
import 'package:quran_app/servises/page/page_provider.dart';
import 'package:quran_app/servises/provider.dart';
import 'package:quran_app/shared/functionalty.dart';
import 'package:quran_app/widgets/home_app_bar.dart';
import '../widgets/page_body.dart';

class PartScreen extends StatefulWidget {
  const PartScreen(
      {Key? key,
      required this.pages,
      required this.partName,
      required this.firstPageNum,
      this.connectivityResult,
      required this.partNo})
      : super(key: key);
  final List<QPage> pages;
  final String partName;
  final int partNo;
  final int firstPageNum;
  final ConnectivityResult? connectivityResult;

  @override
  State<PartScreen> createState() => _PartScreenState();
}

class _PartScreenState extends State<PartScreen> {
  bool isPined = false;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();

    // controller.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double progress = 0;

  // int _currentPage = 0;
  // void _onPageChanged() {
  //   setState(() {
  //     if (controller.positions.isNotEmpty) {
  //       _currentPage = controller.page?.round() ?? 0;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<PageProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: HomeAppBar(
              title: widget.partName,
              pageLength: widget.pages.length,
            ),
            body: Consumer<BookmarkProvider>(
              builder: (context, provider, child) {
                return PageBody(
                  // controller: controller,
                  // isPined: isPined,
                  pages: widget.pages,
                  // connectivityResult: widget.connectivityResult,
                  firstPageNum: widget.firstPageNum,
                  // function: (double progress) {
                  //   setState(() {
                  //     this.progress = progress;
                  //   });
                  // },
                  isPartScreen: true,
                  bookmark: getBookMark(provider.bookmarks, widget.partNo),
                );
              },
            ),
          );
        },
      ),
    );
  }

// int getPreviousIndex() => pageNumber - 1;
}
