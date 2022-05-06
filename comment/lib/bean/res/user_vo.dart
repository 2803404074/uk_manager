/// age : 0
/// cover : "https://img1.baidu.com/it/u=980679323,2277132941&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=401"
/// createdAt : "2022-01-26T16:41:22"
/// deleted : 0
/// fansNumber : 1
/// gender : 0
/// hasCoach : 0
/// hasVip : 0
/// hobby : ""
/// id : 9
/// introduction : ""
/// label : ""
/// nickName : "6"
/// occupation : ""
/// openId : ""
/// phone : "18894720202"
/// photoAlbumId : 0
/// upNumber : 0
/// updatedAt : "2022-02-10T16:34:11"
/// updaterId : 7
/// version : 17

class UserVo {
  UserVo({
      this.age, 
      this.cover, 
      this.createdAt, 
      this.deleted, 
      this.fansNumber, 
      this.gender, 
      this.hasCoach, 
      this.hasVip, 
      this.hobby, 
      this.id, 
      this.introduction, 
      this.label, 
      this.nickName, 
      this.occupation, 
      this.openId, 
      this.phone, 
      this.photoAlbumId, 
      this.upNumber, 
      this.updatedAt, 
      this.updaterId, 
      this.version,});

  UserVo.fromJson(dynamic json) {
    age = json['age'];
    cover = json['cover'];
    createdAt = json['createdAt'];
    deleted = json['deleted'];
    fansNumber = json['fansNumber'];
    gender = json['gender'];
    hasCoach = json['hasCoach'];
    hasVip = json['hasVip'];
    hobby = json['hobby'];
    id = json['id'];
    introduction = json['introduction'];
    label = json['label'];
    nickName = json['nickName'];
    occupation = json['occupation'];
    openId = json['openId'];
    phone = json['phone'];
    photoAlbumId = json['photoAlbumId'];
    upNumber = json['upNumber'];
    updatedAt = json['updatedAt'];
    updaterId = json['updaterId'];
    version = json['version'];
  }
  int? age;
  String? cover;
  String? createdAt;
  int? deleted;
  int? fansNumber;
  int? gender;
  int? hasCoach;
  int? hasVip;
  String? hobby;
  int? id;
  String? introduction;
  String? label;
  String? nickName;
  String? occupation;
  String? openId;
  String? phone;
  int? photoAlbumId;
  int? upNumber;
  String? updatedAt;
  int? updaterId;
  int? version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['age'] = age;
    map['cover'] = cover;
    map['createdAt'] = createdAt;
    map['deleted'] = deleted;
    map['fansNumber'] = fansNumber;
    map['gender'] = gender;
    map['hasCoach'] = hasCoach;
    map['hasVip'] = hasVip;
    map['hobby'] = hobby;
    map['id'] = id;
    map['introduction'] = introduction;
    map['label'] = label;
    map['nickName'] = nickName;
    map['occupation'] = occupation;
    map['openId'] = openId;
    map['phone'] = phone;
    map['photoAlbumId'] = photoAlbumId;
    map['upNumber'] = upNumber;
    map['updatedAt'] = updatedAt;
    map['updaterId'] = updaterId;
    map['version'] = version;
    return map;
  }

}