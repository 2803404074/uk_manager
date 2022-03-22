import 'package:comment/const/api.dart';
import 'package:comment/const/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:uk_manager/provider/base_model.dart';
import 'package:comment/bean/res/curriculum_vo.dart';
import 'package:comment/bean/req/curriculum_post_form.dart';

class CurriculumModel extends BaseModel {
  int oneCurrentIndex = 0;
  int towCurrentIndex = 0;
  int threeCurrentIndex = 0;
  int fourCurrentIndex = -1;

  List<String> oneList = [
    '全部',
    '审核通过',
    '未通过',
  ];

  List<String> towList = [
    '全部',
    '免费',
    'vip',
    '收费',
  ];

  List<String> threeList = [
    '全部',
    '今日发布',
    '一周内',
    '一个月内',
    '一年内',
  ];

  List<dynamic> fourList = [];

  List<CurriculumVo> curriculumList = [];

  CurriculumModel(BuildContext context) : super(context) {
    getTypeList();
  }

  void changeIndex(int type, int index) {
    if (type == 0) oneCurrentIndex = index;
    if (type == 1) towCurrentIndex = index;
    if (type == 2) threeCurrentIndex = index;
    if (type == 3) fourCurrentIndex = index;

    notifyListeners();
  }

  void loadList(bool loadMore,
      {int? currentIndex, String? queryKey, int? status, int? hasVip}) {
    if (currentIndex != null && currentIndex != page) {
      page = currentIndex;
      notifyListeners();
    } else {
      setLoadMore(loadMore);
    }

    var parameter = CurriculumPostForm();
    parameter.page = MPage(page: page, size: 10);
    parameter.title = '';
    // parameter.status = status;
    // parameter.hasVip = hasVip;
    HttpProxy.httpProxy
        .post(Api.getCurriculumList, parameters: parameter.toJson())
        .then((value) {
      if (value.code == 200) {
        var list = <CurriculumVo>[];
        var records = value.data['records'];
        for (var element in records) {
          list.add(CurriculumVo.fromJson(element));
        }
        if (loadMore) {
          if (list.isNotEmpty) {
            curriculumList.addAll(list);
          } else {}
        } else {
          curriculumList = list;
        }
        notifyListeners();
      }
    }).then((value) {});
  }

  void getTypeList() {
    HttpProxy.httpProxy
        .post(Api.getCurriculumTypeList, parameters: {}).then((res) {
      if (res.code == 200) {
        res.data.forEach((element) {
          fourList.add(element);
        });
        fourList.insert(0, {
          'name': '全部',
        });
        fourCurrentIndex = 0;
        loadList(false);
      }
    }).onError((error, stackTrace) {});

    for (int i = 0; i < 50; i++) {
      curriculumList.add(CurriculumVo(
          cover:
              'https://img2.baidu.com/it/u=3264322578,2737237663&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500',
              title: '标题',
        nickName: '昵称',
        postTime: '2222',
        status: 0,

      ));
    }
  }
}
