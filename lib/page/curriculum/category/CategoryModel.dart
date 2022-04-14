

import 'package:comment/const/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:uk_manager/provider/base_model.dart';
import 'package:uk_manager/utils/dialog_util.dart';

class CategoryModel extends BaseModel{

  List<dynamic> list = [];
  CategoryModel(BuildContext context) : super(context){
    getData();
  }

  void getData()async{
    HttpProxy.httpProxy.get(Api.offAdv).then((value){

    }).onError((error, stackTrace){

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