class Lecture {
  String? title;
  String? uploadedTime;
  int? views;
  int? comments;
  int? downloads;
  bool downloaded = false;
  String? thumbNailAsset;
  String? videoAsset;
  String? videoAssetCode;
  int? id;
  String? classId;
  String? lectureId;

  Lecture();

  Lecture.setData(
      {required this.id,
      this.title,
      this.uploadedTime,
      this.views,
      this.downloads,
      this.videoAsset,
      this.classId,
      this.lectureId,
      this.thumbNailAsset,
      this.videoAssetCode,
      this.downloaded = false,
      this.comments});

  // Lecture.setData({
  //   this.id,
  //   this.uploadedTime,
  // });

  factory Lecture.fromJson(Map<dynamic, dynamic> map) {
    return Lecture.setData(
        id: map['id'],
        title: map['title'],
        uploadedTime: map['uploadedTime'],
        views: map['views'],
        comments: map['comments'],
        classId: map['ClassId'],
        lectureId: map['LectureId'],
        videoAsset: map['videoAsset'],
        videoAssetCode: map['videoAssetCode'],
        thumbNailAsset: map['thumbNailAsset'],
        downloaded: map.containsKey('downloaded') ? map['downloaded'] : false,
        downloads: map['downloads']);
  }

  List<Lecture> fromJsonArr(List list) {
    return List<Lecture>.from(list.map((x) => Lecture.fromJson(x)));
  }
}
