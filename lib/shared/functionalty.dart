import '../models/bookmark.dart';

Bookmark? getBookMark(List<Bookmark>bookmarks,int by){
  Bookmark? b;
  bookmarks.forEach((element) {
    if(element.id==by){
      b= element;
    }
  });
  return b;
}

String getJozzName(int value) {
  switch (value) {
    case 1:
      return 'الجزء الأول';
    case 2:
      return 'الجزء الثاني';
    case 3:
      return 'الجزء الثالث';
    case 4:
      return 'الجزء الرابع';
    case 5:
      return 'الجزء الخامس';
    case 6:
      return 'الجزء السادس';
    case 7:
      return 'الجزء السابع';
    case 8:
      return 'الجزء الثامن';
    case 9:
      return 'الجزء التاسع';
    case 10:
      return 'الجزء العاشر';
    case 11:
      return 'الجزء الحادي عشر';
    case 12:
      return 'الجزء الثاني عشر';
    case 13:
      return 'الجزء الثالث عشر';
    case 14:
      return 'الجزء الرابع عشر';
    case 15:
      return 'الجزء الخامس عشر';
    case 16:
      return 'الجزء السادس عشر';
    case 17:
      return 'الجزء السابع عشر';
    case 18:
      return 'الجزء الثامن عشر';
    case 19:
      return 'الجزء التاسع عشر';
    case 20:
      return 'الجزء العشرون';
    case 21:
      return 'الجزء الحادي والعشرون';
    case 22:
      return 'الجزء الثاني والعشرون';
    case 23:
      return 'الجزء الثالث والعشرون';
    case 24:
      return 'الجزء الرابع والعشرون';
    case 25:
      return 'الجزء الخامس والعشرون';
    case 26:
      return 'الجزء السادس والعشرون';
    case 27:
      return 'الجزء السابع والعشرون';
    case 28:
      return 'الجزء الثامن والعشرون';
    case 29:
      return 'الجزء التاسع والعشرون';
    case 30:
      return 'الجزء الثلاثون';
    default:
      return 'غير معروف'; // This will be returned if none of the cases match.
  }
}
