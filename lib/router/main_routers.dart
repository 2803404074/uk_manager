
import 'package:flutter/cupertino.dart';
import 'package:uk_manager/page/main/index_page.dart';
import 'package:uk_manager/page/main/welcome_page.dart';

import '../page/edu/details/curriculum_details_page.dart';

///路由表
class MainRouter {
  ///主页
  static const String welcomePage = 'welcomePage';
  static const String indexPage = 'indexPage';

  ///课程详情
  static const String curriculumDetailsPage = 'curriculumDetailsPage';

  static Map<String, WidgetBuilder> mainRouters() {
    var mainRouters = {
      welcomePage: (context, {arguments}) => const WelcomePage(),
      indexPage:(context, {arguments}) => const IndexPage(),
      curriculumDetailsPage: (context, {arguments}) => CurriculumDetailsPage(
        cId: arguments['cId'],
      ),

    };

    return mainRouters;
  }
}
