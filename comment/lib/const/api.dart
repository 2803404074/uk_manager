class Api {
  ///----------------用户----------------
  ///用户列表，多条件
  static const String userList = 'web/user/list';





  ///----------------课程----------------

  ///获取课程列表(多条件)
  static const String getCurriculumList = 'curriculum/page/list';

  ///课程分类列表
  static const String getCurriculumTypeList = 'web/curriculum/list';

  ///添加课程分类
  static const String addType = 'web/curriculum/add';

  ///删除课程分类
  static const String deleteType = 'web/curriculum/delete';

  ///修改课程分类
  static const String updateType = 'web/curriculum/update';



  ///--------------首页推荐模块管理--------------

  ///添加首页推荐模块
  static const String addModular = 'web/curriculumModular/addModular';

  ///移除首页推荐某个模块
  static const String removeModular = 'web/curriculumModular/removeModular';

  ///修改模块内容
  static const String updateModular = 'web/curriculumModular/updateModular';

  ///推荐模块列表
  static const String allModular = 'web/curriculumModular/allModular';

  ///添加或删除模块的课程
  static const String addAndRemoveModularCurriculum = 'web/curriculumModular/addAndRemoveModularCurriculum';




  ///----------------入驻管理----------------
  static const String applicantDetails = 'web/applicant/applicantDetails';
  static const String getApplicantList = 'web/applicant/page/list';
  static const String passApplicant = 'web/applicant/pass';







  ///----------------广告类型管理----------------
  ///广告类型列表
  static const String advTypeList = 'web/adv/advTypeList';
  ///添加广告类型
  static const String addAdvType = 'web/adv/addAdvType';
  ///上下线广告类型
  static const String offAdvType = 'web/adv/offAdvType';


  ///----------------广告管理----------------
  static const String addAdv = 'web/adv/addAdv';
  static const String updateAdv = 'web/adv/updateAdv';
  static const String getAdvList = 'web/adv/getAdvList';
  static const String getAdvDetails = 'web/adv/advDetails';
  static const String offAdv = 'web/adv/offAdv';
}
