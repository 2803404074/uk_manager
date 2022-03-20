/// id : 1
/// curriculumId : 1
/// title : "x"
/// hasCharge : 1
/// hasVip : 1
/// cover : "x"
/// videoUrl : "x"
/// money : 0.12
/// creatorId : 1
/// createdAt : "string"
/// updaterId : "string"
/// updatedAt : "string"

class VideoVo {
  VideoVo({
      this.id, 
      this.curriculumId, 
      this.title, 
      this.hasCharge, 
      this.hasVip, 
      this.cover, 
      this.videoUrl, 
      this.money, 
      this.creatorId, 
      this.createdAt, 
      this.updaterId, 
      this.updatedAt,});

  VideoVo.fromJson(dynamic json) {
    id = json['id'];
    curriculumId = json['curriculumId'];
    title = json['title'];
    hasCharge = json['hasCharge'];
    hasVip = json['hasVip'];
    cover = json['cover'];
    videoUrl = json['videoUrl'];
    money = json['money'];
    creatorId = json['creatorId'];
    createdAt = json['createdAt'];
    updaterId = json['updaterId'];
    updatedAt = json['updatedAt'];
  }
  int? id;
  int? curriculumId;
  String? title;
  int? hasCharge;
  int? hasVip;
  String? cover;
  String? videoUrl;
  int? money;
  int? creatorId;
  String? createdAt;
  int? updaterId;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['curriculumId'] = curriculumId;
    map['title'] = title;
    map['hasCharge'] = hasCharge;
    map['hasVip'] = hasVip;
    map['cover'] = cover;
    map['videoUrl'] = videoUrl;
    map['money'] = money;
    map['creatorId'] = creatorId;
    map['createdAt'] = createdAt;
    map['updaterId'] = updaterId;
    map['updatedAt'] = updatedAt;
    return map;
  }

}