
import 'video_vo.dart';

/// id : 3
/// userId : 2
/// nickName : "音乐队长－阿木木"
/// userCover : ""
/// title : "hhhh"
/// introduce : "hhvgw"
/// hasCharge : 0
/// hasVip : 0
/// cover : "http://tuhaolili.top/Fo5ZeurYTz5Qe1vTbhM1seQEnUgY"
/// money : 0
/// curriculumTypeId : 6
/// curriculumTypeName : null
/// label : "bhh"
/// difficulty : "小白"
/// collectNumber : 0
/// upNumber : 0
/// commentNumber : 0
/// number : 0
/// postTime : "2022-01-19 17:38:59"
/// status : 0
/// videos : null
/// comments : null

class CurriculumVo {
  CurriculumVo({
      this.id, 
      this.userId, 
      this.nickName, 
      this.userCover, 
      this.title, 
      this.introduce, 
      this.hasCharge, 
      this.hasVip, 
      this.cover, 
      this.money, 
      this.curriculumTypeId, 
      this.curriculumTypeName, 
      this.label, 
      this.difficulty, 
      this.collectNumber, 
      this.upNumber, 
      this.commentNumber, 
      this.number, 
      this.postTime, 
      this.status, 
      this.videos, 
      this.comments,
    this.hotsNumber,
  });

  CurriculumVo.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    nickName = json['nickName'];
    userCover = json['userCover'];
    title = json['title'];
    introduce = json['introduce'];
    hasCharge = json['hasCharge'];
    hasVip = json['hasVip'];
    cover = json['cover'];
    money = json['money'];
    curriculumTypeId = json['curriculumTypeId'];
    curriculumTypeName = json['curriculumTypeName']??'';
    label = json['label'];
    difficulty = json['difficulty'];
    collectNumber = json['collectNumber'];
    upNumber = json['upNumber'];
    commentNumber = json['commentNumber'];
    number = json['number'];
    postTime = json['postTime'];
    status = json['status'];
    if(json['videos']!=null){
      var list=<VideoVo>[];
      for(var el in json['videos']){
        list.add(VideoVo.fromJson(el));
      }
      videos = list;
    }
    comments = json['comments'];
    hotsNumber = json['hotsNumber'];
    hasUp = json['hasUp'];
    hasFans = json['hasFans'];
    hasCollect = json['hasCollect'];
  }
  int? id;
  int? userId;
  String? nickName;
  String? userCover;
  String? title;
  String? introduce;
  int? hasCharge;
  int? hasVip;
  String? cover;
  int? money;
  int? curriculumTypeId;
  String? curriculumTypeName;
  String? label;
  String? difficulty;
  int? collectNumber;
  int? upNumber;
  int? commentNumber;
  int? number;
  String? postTime;
  int? status;
  int? hotsNumber;
  bool? hasFans;
  bool? hasUp;
  bool? hasCollect;
  List<VideoVo>? videos;
  dynamic comments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['nickName'] = nickName;
    map['userCover'] = userCover;
    map['title'] = title;
    map['introduce'] = introduce;
    map['hasCharge'] = hasCharge;
    map['hasVip'] = hasVip;
    map['cover'] = cover;
    map['money'] = money;
    map['curriculumTypeId'] = curriculumTypeId;
    map['curriculumTypeName'] = curriculumTypeName;
    map['label'] = label;
    map['difficulty'] = difficulty;
    map['collectNumber'] = collectNumber;
    map['upNumber'] = upNumber;
    map['commentNumber'] = commentNumber;
    map['number'] = number;
    map['postTime'] = postTime;
    map['status'] = status;
    map['videos'] = videos;
    map['comments'] = comments;
    return map;
  }

}