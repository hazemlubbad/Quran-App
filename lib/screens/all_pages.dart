import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/models/page.dart';
import 'package:quran_app/servises/page/page_provider.dart';
import 'package:quran_app/servises/provider.dart';
import 'package:quran_app/shared/functionalty.dart';
import 'package:quran_app/widgets/home_app_bar.dart';
import '../widgets/home_drawer.dart';
import '../widgets/page_body.dart';

class AllPagesScreen extends StatelessWidget {
  const AllPagesScreen({Key? key, required this.pages}) : super(key: key);
  final List<QPage> pages;

  @override
  Widget build(BuildContext context) {
    PageProvider provider = Provider.of<PageProvider>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: HomeDrawer(pages: pages),
        appBar: HomeAppBar(
          pageLength: pages.length,
        ),
        body: Consumer<BookmarkProvider>(
          builder: (context, bProvider, child) {
            return PageBody(
              pages: pages,
              bookmark: getBookMark(bProvider.bookmarks, 0),
            );
          },
        ),
      ),
    );
  }
}
