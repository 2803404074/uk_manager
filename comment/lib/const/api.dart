class Api {
  ///----------------课程----------------

  ///获取课程列表(多条件)
  static const String getCurriculumList = 'curriculum/page/list';

  ///获取课程分类列表
  static const String getCurriculumTypeList = 'curriculuma/type/list';

  ///----------------入驻管理----------------





  ///----------------广告类型管理----------------
  ///广告类型列表
  static const String advTypeList = 'web/adv/advTypeList';
  ///添加广告类型
  static const String addAdvType = 'web/adv/addAdvType';
  ///上下线广告类型
  static const String offAdvType = 'web/adv/offAdvType';


  ///----------------广告管理----------------
  static const String addAdv = 'web/adv/addAdv';
  static const String getAdvList = 'web/adv/getAdvList';
  static const String getAdvDetails = 'web/adv/advDetails';
}
