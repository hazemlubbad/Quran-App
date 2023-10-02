import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/models/bookmark.dart';
import 'package:quran_app/servises/page/page_provider.dart';
import 'package:quran_app/widgets/quran_page.dart';
import '../models/page.dart';

class PageBody extends StatefulWidget {
  const PageBody({
    super.key,
    required this.pages,
    this.firstPageNum = 1,
    this.isPartScreen = false,
    this.bookmark,
  });

  final int firstPageNum;
  final List<QPage> pages;
  final bool isPartScreen;
  final Bookmark? bookmark;

  @override
  State<PageBody> createState() => _PageBodyState();
}

class _PageBodyState extends State<PageBody> {
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
