import 'dart:convert';

/// applicationType : 0
/// createdAt : "2022-03-10T15:02:20"
/// creatorId : 15
/// creditCode : "1234"
/// deleted : 0
/// goodAt : "跳舞，两年"
/// id : 5
/// identityNumber : "78464645484845464"
/// identityUrl : "[\"http://tuhaolili.top/FrZIu3KOfM4CdiW3R009z5n4uaKL\",\"http://tuhaolili.top/FrZIu3KOfM4CdiW3R009z5n4uaKL\",\"http://tuhaolili.top/FrZIu3KOfM4CdiW3R009z5n4uaKL\"]"
/// location : "123,456"
/// organizationName : "xxx健身房"
/// organizationUrl : "www.baidu.com"
/// phoneNum : "4545464346494"
/// qualificationsUrl : "[\"http://tuhaolili.top/FrZIu3KOfM4CdiW3R009z5n4uaKL\"]"
/// realName : "哈哈哈哈"
/// status : 2
/// tradeType : "健身"
/// updatedAt : "2022-03-25T23:34:32"
/// updaterId : 15
/// userId : 15
/// version : 0

class ApplicantVo {
  ApplicantVo({
      this.applicationType, 
      this.createdAt, 
      this.creatorId, 
      this.creditCode, 
      this.deleted, 
      this.goodAt, 
      this.id, 
      this.identityNumber, 
      this.identityUrl, 
      this.location, 
      this.organizationName, 
      this.organizationUrl, 
      this.phoneNum, 
      this.qualificationsUrl, 
      this.realName, 
      this.status, 
      this.tradeType, 
      this.updatedAt, 
      this.updaterId, 
      this.userId, 
      this.version,});

  ApplicantVo.fromJson(dynamic jsonStr) {
    try{
      applicationType = jsonStr['applicationType'];
      createdAt = jsonStr['createdAt'];
      creatorId = jsonStr['creatorId'];
      creditCode = jsonStr['creditCode'];
      deleted = jsonStr['deleted'];
      goodAt = jsonStr['goodAt'];
      id = jsonStr['id'];
      identityNumber = jsonStr['identityNumber'];
      var identityUrlStr = jsonStr['identityUrl'];
      try{
        if(identityUrlStr!=null){
          identityUrl = json.decode(identityUrlStr);
        }
      }catch(e){
        print('解析异常:${e.toString()}');
      }
      location = jsonStr['location'];
      organizationName = jsonStr['organizationName'];
      organizationUrl = jsonStr['organizationUrl'];
      phoneNum = jsonStr['phoneNum'];
      var quaStr = jsonStr['qualificationsUrl'];
      try{
        if(quaStr!=null){
          qualificationsUrl = json.decode(quaStr);
        }
      }catch(e){
        print('解析异常2:${e.toString()}');
      }
      realName = jsonStr['realName'];

      status = jsonStr['status'];
      tradeType = jsonStr['tradeType'];
      updatedAt = jsonStr['updatedAt'];
      updaterId = jsonStr['updaterId'];
      userId = jsonStr['userId'];
      version = jsonStr['version'];
    }catch(e){
      print('解析异常3:${e.toString()}');
    }

  }
  int? applicationType;
  String? createdAt;
  int? creatorId;
  String? creditCode;
  int? deleted;
  String? goodAt;
  int? id;
  String? identityNumber;
  List<dynamic>? identityUrl;
  String? location;
  String? organizationName;
  String? organizationUrl;
  String? phoneNum;
  List<dynamic>? qualificationsUrl;
  String? realName;
  int? status;
  String? tradeType;
  String? updatedAt;
  int? updaterId;
  int? userId;
  int? version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicationType'] = applicationType;
    map['createdAt'] = createdAt;
    map['creatorId'] = creatorId;
    map['creditCode'] = creditCode;
    map['deleted'] = deleted;
    map['goodAt'] = goodAt;
    map['id'] = id;
    map['identityNumber'] = identityNumber;
    map['identityUrl'] = identityUrl;
    map['location'] = location;
    map['organizationName'] = organizationName;
    map['organizationUrl'] = organizationUrl;
    map['phoneNum'] = phoneNum;
    map['qualificationsUrl'] = qualificationsUrl;
    map['realName'] = realName;
    map['status'] = status;
    map['tradeType'] = tradeType;
    map['updatedAt'] = updatedAt;
    map['updaterId'] = updaterId;
    map['userId'] = userId;
    map['version'] = version;
    return map;
  }

}