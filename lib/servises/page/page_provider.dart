import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/models/bookmark.dart';
import 'package:quran_app/servises/page/page_brain.dart';
import 'package:quran_app/servises/provider.dart';

class PageProvider extends ChangeNotifier {
  PageBrain pageBrain = PageBrain();
  void init(BuildContext context) {
    List<Bookmark> bookmarks =
        Provider.of<BookmarkProvider>(context, listen: false).bookmarks;
    pageBrain.setPageController(
        PageController(initialPage: getBookMark(bookmarks, 0)?.pageNo ?? 0));
    pageBrain.testConnectivity();
    notifyListeners();
  }

  double getProgress() {
    return pageBrain.progress;
  }

  void setProgress(double progress) {
    pageBrain.progress = progress;
    notifyListeners();
  }

  ConnectivityResult? getConnectivityResult() {
    return pageBrain.connectivityResult;
  }

  PageController getController() {
    return pageBrain.getController();
  }

  Bookmark? getBookMark(List<Bookmark> bookmarks, int by) {
    Bookmark? b;
    for (var element in bookmarks) {
      if (element.id == by) {
        b = element;
      }
    }
    return b;
  }

  void shiftPined() {
    pageBrain.shiftPined();
    notifyListeners();
  }

  bool getPined() {
    return pageBrain.getPined();
  }

  void animateTo(int page) {
    pageBrain.animateTo(page);
  }

  void animateToBookmark(BuildContext context) {
    List<Bookmark> bookmarks =
        Provider.of<BookmarkProvider>(context, listen: false).bookmarks;
    pageBrain.animateTo(getBookMark(bookmarks, 0)?.pageNo ?? 0);
  }

  @override
  void dispose() {
    pageBrain.dispose();
    super.dispose();
  }
}
