/// createAt : 1647958385000
/// creatorId : 15
/// deleted : 0
/// id : 1
/// status : 0
/// typeName : "首页"
/// updatedAt : 1647958387000
/// version : 0

class Adv_type_vo {
  Adv_type_vo({
      this.createAt, 
      this.creatorId, 
      this.deleted, 
      this.id, 
      this.status, 
      this.typeName, 
      this.updatedAt, 
      this.version,});

  Adv_type_vo.fromJson(dynamic json) {
    createAt = json['createAt'];
    creatorId = json['creatorId'];
    deleted = json['deleted'];
    id = json['id'];
    status = json['status'];
    typeName = json['typeName'];
    updatedAt = json['updatedAt'];
    version = json['version'];
  }
  int? createAt;
  int? creatorId;
  int? deleted;
  int? id;
  int? status;
  String? typeName;
  int? updatedAt;
  int? version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createAt'] = createAt;
    map['creatorId'] = creatorId;
    map['deleted'] = deleted;
    map['id'] = id;
    map['status'] = status;
    map['typeName'] = typeName;
    map['updatedAt'] = updatedAt;
    map['version'] = version;
    return map;
  }

}