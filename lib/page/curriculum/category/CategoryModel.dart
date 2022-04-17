
import 'dart:convert';
import 'dart:html';

import 'package:comment/const/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:uk_manager/provider/base_model.dart';
import 'package:uk_manager/utils/dialog_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class TypeVo{
  int? id;
  String? icon;
  String? name;
  TypeVo({required this.id,required this.icon,required this.name});

  factory TypeVo.fromJson(dynamic json){
    print('内容:$json');
    return TypeVo(
      id: json['id'],
      icon: json['icon'],
      name: json['name']
    );
  }
}


class CategoryModel extends BaseModel{

  dynamic uploadedImage;
  List<TypeVo> list = [];
  CategoryModel(BuildContext context) : super(context){
    getData();
  }

  final requestDto = <String,dynamic>{};

  void addImage()async{
    FileUploadInputElement? uploadInput = FileUploadInputElement();
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if(files == null)return;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader =  FileReader();
        reader.onLoadEnd.listen((e) {
          uploadedImage = reader.result;
          requestDto['image'] =  MultipartFile.fromBytes(uploadedImage,filename: 'test.jpg');
          notifyListeners();
        });

        reader.onError.listen((fileEvent) {
          requestDto['image']=null;
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }

  void getData()async{
    HttpProxy.httpProxy.get(Api.getCurriculumTypeList).then((res){
      if(res.code == 200){
        print('返回信息:${res.data}');
        print('返回信息:${res.data.length}');
        try{
          json.decode(res.data).forEach((element) {
            list.add(TypeVo.fromJson(element));
          });
        }catch(e){
          print('异常:${e.toString()}');
        }

        success();
      }else{
        err(str: res.message);
      }
    }).onError((error, stackTrace) {
      err(str: error.toString());
    });
  }


  void addType(){
    print('请求内容:$requestDto');
    if(requestDto['image'] == null || requestDto['name'].isEmpty){
      return;
    }
    HttpProxy.httpProxy.post(Api.addType,parameters: requestDto).then((value){
      if(value.code == 200){
        list.insert(0, TypeVo.fromJson(value.data));
        notifyListeners();
      }else{
        DialogUtil.getInstance().showErrDialog(context,errTips: value.message);
      }
    }).onError((error, stackTrace){
      DialogUtil.getInstance().showErrDialog(context,errTips: error.toString());
    });
  }

  void deleteType(int index){
    HttpProxy.httpProxy.post(Api.deleteType,parameters: {'id':list[index].id}).then((value){
      if(value.code == 200){
        list.removeAt(index);
        notifyListeners();
      }else{
        DialogUtil.getInstance().showErrDialog(context,errTips: value.message);
      }
    }).onError((error, stackTrace){
      DialogUtil.getInstance().showErrDialog(context,errTips: error.toString());
    });
  }

}