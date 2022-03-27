
import 'dart:developer';

import 'package:comment/const/api.dart';
import 'package:flutter/material.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:uk_manager/page/edu/bean/edu_vo.dart';
import 'package:uk_manager/provider/base_model.dart';


class EduModel extends BaseModel{

  int typeIndex = 0;
  int statusIndex = 0;
  final statusList=[
    '全部','待审核','通过','未通过'
  ];
  final typeList=[
    '全部','个人','企业'
  ];


  List<Edu_vo> data=[];

  EduModel(BuildContext context) : super(context){
    getEduData();
  }

  void changeStatusIndex(int index){
    statusIndex = index;
    notifyListeners();
  }

  void changeTypeIndex(int index){
    typeIndex = index;
    notifyListeners();
  }

  void getEduData(){
    var map=<String,dynamic>{};
    HttpProxy.httpProxy.post(Api.getApplicantList, parameters: map,jsonRequest: true).then((value){
      if(value.code == 200){
        var records = value.data['records'];
        records.forEach((element) {
          data.add(Edu_vo.fromJson(element));
        });
        notifyListeners();
      }
    }).onError((error, stackTrace){

    });
  }


  ///
  /// 0未审核
  /// 1通过
  /// 2不通过
  Future<bool> pass(int index,int status)async{
    var map={
      'id':data[index].id,
      'status':status,
      'message':'尊敬${data[index].nickName}您好,您${status==1?'已':'未'}通过私教认证',
    };
    var value = await HttpProxy.httpProxy.post(Api.passApplicant, parameters: map);
    if(value.code == 200){
      data[index].status = status;
      notifyListeners();
      return true;
    }
    return false;
  }
}