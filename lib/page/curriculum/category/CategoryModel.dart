

import 'dart:convert';
import 'dart:developer';

import 'package:comment/const/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:uk_manager/provider/base_model.dart';
import 'package:uk_manager/utils/dialog_util.dart';

class TypeVo{
  int id;
  String icon;
  String name;
  TypeVo({required this.id,required this.icon,required this.name});

  factory TypeVo.fromJson(dynamic json){
    return TypeVo(
      id: json['id'],
      icon: json['icon'],
      name: json['name']
    );
  }
}


class CategoryModel extends BaseModel{

  List<TypeVo> list = [];
  CategoryModel(BuildContext context) : super(context){
    getData();
  }

  void getData()async{
    HttpProxy.httpProxy.get(Api.getCurriculumTypeList,parameters: {}).then((res){
      if(res.code == 200){
        print('返回信息:${res.data}');
        res.data.forEach((element) {
          print('返回信息1111');
          list.add(TypeVo.fromJson(element));
          print('返回信息:2222');
        });
        success();
      }else{
        err(str: res.message);
      }
    }).onError((error, stackTrace) {
      err(str: error.toString());
    });
  }


  void addType(){
    HttpProxy.httpProxy.get(Api.offAdv).then((value){
      if(value.code == 200){
        list.insert(0, value.data);
      }else{
        DialogUtil.getInstance().showErrDialog(context,errTips: value.message);
      }
    }).onError((error, stackTrace){
      DialogUtil.getInstance().showErrDialog(context,errTips: error.toString());
    });
  }

  void deleteType(int index){
    HttpProxy.httpProxy.get(Api.offAdv).then((value){
      if(value.code == 200){
        list.removeAt(index);
      }else{
        DialogUtil.getInstance().showErrDialog(context,errTips: value.message);
      }
    }).onError((error, stackTrace){
      DialogUtil.getInstance().showErrDialog(context,errTips: error.toString());
    });
  }

}