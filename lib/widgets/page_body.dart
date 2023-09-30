import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/models/bookmark.dart';
import 'package:quran_app/servises/page/page_provider.dart';
import 'package:quran_app/widgets/quran_page.dart';
import '../models/page.dart';

class PageBody extends StatefulWidget {
  const PageBody({
    super.key,
    // required this.controller,
    // required this.isPined,
    required this.pages,
    // required this.connectivityResult,
    this.firstPageNum = 1,
    // this.function,
    this.isPartScreen = false,
    this.bookmark,
  });

  final int firstPageNum;
  // final PageController controller;
  // final bool isPined;
  final List<QPage> pages;
  // final ConnectivityResult? connectivityResult;
  // final Function(double progress)? function;
  final bool isPartScreen;
  final Bookmark? bookmark;

  @override
  State<PageBody> createState() => _PageBodyState();
}

class _PageBodyState extends State<PageBody> {
  // late PageController controller;
  //
  // @override
  // void initState() {
  //   controller = PageController(
  //       initialPage:
  //           widget.bookmark == null ? 0 : widget.bookmark?.pageNo ?? 0);
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, provider, child) {
        return PageView.builder(
          controller: provider.getController(),
          physics:
              provider.getPined() ? const NeverScrollableScrollPhysics() : null,
          onPageChanged: (index) {
            provider.setProgress(index / (widget.pages.length - 1));
            // widget.function(index / (widget.pages.length - 1));
          },
          itemBuilder: (context, index) {
            return QPageScreen(
              pageNumber: index + widget.firstPageNum,
              index: index,
              page: widget.pages[index].suras,
              connectivityResult: provider.getConnectivityResult(),
              isPartScreen: widget.isPartScreen,
              bookmark: widget.bookmark,
            );
          },
          itemCount: widget.pages.length,
        );
      },
    );
  }
}
