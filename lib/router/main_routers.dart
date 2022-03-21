
import 'package:flutter/cupertino.dart';
import 'package:uk_manager/page/main/index_page.dart';
import 'package:uk_manager/page/main/welcome_page.dart';

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
  static const String eduListDetailsPage = 'eduListDetailsPage';


  static Map<String, WidgetBuilder> mainRouters() {
    var mainRouters = {
      welcomePage: (context, {arguments}) => const WelcomePage(),
      indexPage:(context, {arguments}) => const IndexPage(),
      curriculumDetailsPage: (context, {arguments}) => CurriculumDetailsPage(
        cId: arguments['cId'],
      ),
      eduListDetailsPage: (context, {arguments}) => EduDetailsPage(
        eId: arguments['eId'],
      ),

    };

    return mainRouters;
  }
}
