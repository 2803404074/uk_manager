/// curriculumTypeId : 0
/// hasCharge : 0
/// hasVip : 0
/// page : {"order":"","page":1,"size":10}
/// status : 0
/// title : ""
/// userId : 0

class CurriculumPostForm {
  CurriculumPostForm({
    this.businessId,
      this.curriculumTypeId, 
      this.hasCharge, 
      this.hasVip, 
      this.page, 
      this.status, 
      this.title,
      this.userId,});

  CurriculumPostForm.fromJson(dynamic json) {
    curriculumTypeId = json['curriculumTypeId'];
    hasCharge = json['hasCharge'];
    hasVip = json['hasVip'];
    page = json['page'] != null ? MPage.fromJson(json['page']) : null;
    status = json['status'];
    title = json['title'];
    userId = json['userId'];
  }
  int? curriculumTypeId;
  int? businessId;
  int? hasCharge;
  int? hasVip;
  MPage? page;
  int? status;
  String? title;
  int? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['curriculumTypeId'] = curriculumTypeId;
    map['businessId'] = businessId;
    map['hasCharge'] = hasCharge;
    map['hasVip'] = hasVip;
    if (page != null) {
      map['page'] = page?.toJson();
    }
    map['status'] = status;
    map['title'] = title;
    map['userId'] = userId;
    return map;
  }

}

/// order : ""
/// page : 1
/// size : 10

class MPage {
  MPage({
    this.order,
      this.page, 
      this.size,});

  MPage.fromJson(dynamic json) {
    order = json['order'];
    page = json['page'];
    size = json['size'];
  }
  String? order;
  int? page;
  int? size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order'] = order;
    map['page'] = page;
    map['size'] = size;
    return map;
  }

}