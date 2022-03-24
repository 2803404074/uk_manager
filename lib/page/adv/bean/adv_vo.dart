/// advTypeId : 1
/// clickNum : 0
/// cover : "https://img0.baidu.com/it/u=1128022712,196989247&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=267"
/// createAt : "2022-03-22T14:19:27"
/// creatorId : 15
/// deleted : 0
/// id : 1
/// linkUrl : "http://www.baidu.com"
/// local : 0
/// status : 0
/// title : "广告标题标题111"
/// updatedAt : "2022-03-22T14:19:29"
/// version : 0

class Adv_vo {
  Adv_vo({
      this.advTypeId, 
      this.clickNum, 
      this.cover, 
      this.createdAt,
      this.creatorId, 
      this.deleted, 
      this.id, 
      this.linkUrl, 
      this.local, 
      this.status, 
      this.title, 
      this.updatedAt, 
      this.version,});

  Adv_vo.fromJson(dynamic json) {
    advTypeId = json['advTypeId'];
    clickNum = json['clickNum'];
    cover = json['cover'];
    createdAt = json['createdAt'];
    creatorId = json['creatorId'];
    deleted = json['deleted'];
    id = json['id'];
    linkUrl = json['linkUrl'];
    local = json['local'];
    status = json['status'];
    title = json['title'];
    updatedAt = json['updatedAt'];
    version = json['version'];
  }
  int? advTypeId;
  int? clickNum;
  String? cover;
  String? createdAt;
  int? creatorId;
  int? deleted;
  int? id;
  String? linkUrl;
  int? local;
  int? status;
  String? title;
  String? updatedAt;
  int? version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['advTypeId'] = advTypeId;
    map['clickNum'] = clickNum;
    map['cover'] = cover;
    map['createdAt'] = createdAt;
    map['creatorId'] = creatorId;
    map['deleted'] = deleted;
    map['id'] = id;
    map['linkUrl'] = linkUrl;
    map['local'] = local;
    map['status'] = status;
    map['title'] = title;
    map['updatedAt'] = updatedAt;
    map['version'] = version;
    return map;
  }

}