

import 'package:flutter/cupertino.dart';
import 'package:uk_manager/page/adv/list/adv_list_page.dart';
import 'package:uk_manager/page/curriculum/category/category_page.dart';
import 'package:uk_manager/page/curriculum/list/curriculum_page.dart';
import 'package:uk_manager/page/curriculum/modular/curriculum_modular_page.dart';
import 'package:uk_manager/page/edu/list/edu_list_page.dart';
import 'package:uk_manager/provider/base_model.dart';



class MenuVo{
  String title;
  List<SubMenu> menuList;
  MenuVo(this.title,this.menuList);
}
class SubMenu{
  String title;
  int pageIndex;
  bool? selector;
  SubMenu(this.title,this.pageIndex,{this.selector=false});
}


class IndexModel extends BaseModel{
  int currentIndex = 0;
  final controller = PageController(keepPage: true);
  void changePageIndex(int index){
    currentIndex = index;
    controller.jumpToPage(index);
    notifyListeners();
  }

  final menuMasterList=<MenuVo>[];

  IndexModel(BuildContext context) : super(context){
    _initMenu();
  }
  void _initMenu(){
    var curriculumMenuList = <SubMenu>[];
    curriculumMenuList.add(SubMenu('课程分类', 0));
    curriculumMenuList.add(SubMenu('首页课程推荐', 1));
    curriculumMenuList.add(SubMenu('课程审核', 2));
    menuMasterList.add(MenuVo('课程管理', curriculumMenuList));

    var eduMenuList = <SubMenu>[];
    eduMenuList.add(SubMenu('私教审核', 3));
    menuMasterList.add(MenuVo('入驻管理', eduMenuList));


    var userMenuList = <SubMenu>[];
    userMenuList.add(SubMenu('用户管理', 4));
    menuMasterList.add(MenuVo('用户管理', userMenuList));


    var advMenuList = <SubMenu>[];
    advMenuList.add(SubMenu('广告管理', 5));
    menuMasterList.add(MenuVo('广告管理', advMenuList));


    var vipMenuList = <SubMenu>[];
    advMenuList.add(SubMenu('会员管理',6));
    menuMasterList.add(MenuVo('会员管理', vipMenuList));

    var oderMenuList = <SubMenu>[];
    oderMenuList.add(SubMenu('订单管理', 7));
    menuMasterList.add(MenuVo('订单管理', oderMenuList));


    var socialMenuList = <SubMenu>[];
    socialMenuList.add(SubMenu('社交管理', 8));
    menuMasterList.add(MenuVo('社交管理', socialMenuList));


    var labelMenuList = <SubMenu>[];
    labelMenuList.add(SubMenu('标签管理', 9));
    menuMasterList.add(MenuVo('标签管理', labelMenuList));


    var appMenuList = <SubMenu>[];
    appMenuList.add(SubMenu('统计', 10));
    appMenuList.add(SubMenu('更新', 11));
    menuMasterList.add(MenuVo('app版本管理', appMenuList));
  }


}