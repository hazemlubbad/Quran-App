class Bookmark {
  late int id;
  late int pageNo;
  late int suraNo;
  late int ayaNo;
  Bookmark(this.id, this.pageNo, this.suraNo, this.ayaNo);
  Bookmark.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pageNo = json['pageNo'];
    suraNo = json['suraNo'];
    ayaNo = json['ayaNo'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pageNo': pageNo,
      'suraNo': suraNo,
      'ayaNo': ayaNo,
    };
  }

  @override
  String toString() {
    return 'Bookmark(id: $id, pageNo: $pageNo, suraNo: $suraNo, ayaNo: $ayaNo)';
  }
}
