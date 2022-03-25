
import 'package:flutter/cupertino.dart';
import 'package:uk_manager/page/main/index_page.dart';
import 'package:uk_manager/page/main/welcome_page.dart';

import '../page/adv/details/adv_add_edit_page.dart';
import '../page/adv/details/adv_details_page.dart';
import '../page/curriculum/details/curriculum_details_page.dart';
import '../page/edu/details/edu_details_page.dart';

///路由表
class MainRouter {
  ///主页
  static const String welcomePage = 'welcomePage';
  static const String indexPage = 'indexPage';

  ///课程详情
  static const String curriculumDetailsPage = 'curriculumDetailsPage';

  ///私教详情
  static const String eduDetailsPage = 'eduListDetailsPage';


  ///广告详情
  static const String advDetailsPage = 'advDetailsPage';
  ///添加或修改广告
  static const String advAddEditPage = 'advAddEditPage';



  static Map<String, WidgetBuilder> mainRouters() {
    var mainRouters = {
      welcomePage: (context, {arguments}) => const WelcomePage(),
      indexPage:(context, {arguments}) => const IndexPage(),
      curriculumDetailsPage: (context, {arguments}) => CurriculumDetailsPage(
        cId: arguments['cId'],
      ),
      eduDetailsPage: (context, {arguments}) => EduDetailsPage(
        eId: arguments['eId'],
      ),
      advDetailsPage: (context, {arguments}) => AdvDetailsPage(
        tId: arguments['tId'],
        tName: arguments['tName'],
      ),
      advAddEditPage: (context, {arguments}) => AdvAddEditPage(
        model: arguments['model'],
        vo: arguments['vo'],
      ),

    };

    return mainRouters;
  }
}
