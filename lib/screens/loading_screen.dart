import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/models/page.dart';
import 'package:quran_app/screens/all_pages.dart';
import 'package:quran_app/screens/pre_build_pages.dart';
import '../servises/page/page_provider.dart';
import 'home.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  void getFirstPage() async {
    QPage page = QPage();
    await page.getByPage(1);

    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MyHomePage(
          page: page,
        );
      }));
    }
  }

  void getThreePage() async {
    List<QPage> pages = [];
    for (int i = 1; i <= 3; i++) {
      QPage page = QPage();
      await page.getByPage(i);
      pages.add(page);
    }

    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return PreBuildPages(pages: pages);
      }));
    }
  }

  static const int pageNo = 604;
  late Stream<int> _stream;

  Stream<int> getAllPage() async* {
    List<QPage> pages = [];
    for (int i = 1; i <= pageNo; i++) {
      QPage page = QPage();
      await page.getByPage(i);
      pages.add(page);
      yield i;
    }

    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ChangeNotifierProvider(
          create: (BuildContext context) => PageProvider()..init(context),
          child: AllPagesScreen(
            pages: pages,
          ),
        );
      }));
    }
  }

  int progress = 0;

  @override
  void initState() {
    getAllPage().listen((event) {
      setState(() {
        progress = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(progress);
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(
        value: (progress) / pageNo,
      ),
    ));
  }
}
