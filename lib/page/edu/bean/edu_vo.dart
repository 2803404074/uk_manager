/// applicationType : 0
/// cover : "https://img1.baidu.com/it/u=1048231182,1475961204&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=400"
/// createdAt : "2022-03-10T15:02:20"
/// id : 5
/// nickName : "音乐队长－阿木木"
/// status : 0
/// userId : 15

class Edu_vo {
  Edu_vo({
      this.applicationType, 
      this.cover, 
      this.createdAt, 
      this.id, 
      this.nickName, 
      this.status, 
      this.userId,});

  Edu_vo.fromJson(dynamic json) {
    applicationType = json['applicationType'];
    cover = json['cover'];
    createdAt = json['createdAt'];
    id = json['id'];
    nickName = json['nickName'];
    status = json['status'];
    userId = json['userId'];
  }
  int? applicationType;
  String? cover;
  String? createdAt;
  int? id;
  String? nickName;
  int? status;
  int? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicationType'] = applicationType;
    map['cover'] = cover;
    map['createdAt'] = createdAt;
    map['id'] = id;
    map['nickName'] = nickName;
    map['status'] = status;
    map['userId'] = userId;
    return map;
  }

}