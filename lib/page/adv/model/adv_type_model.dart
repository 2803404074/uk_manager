

import 'package:comment/const/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:uk_manager/provider/base_model.dart';

import '../bean/adv_type_vo.dart';

class AdvTypeModel extends BaseModel{


  final List<Adv_type_vo> data = [];

  AdvTypeModel(BuildContext context) : super(context){
    getData();
  }


  void getData(){
    HttpProxy.httpProxy.get(Api.advTypeList).then((value) {
      if(value.code == 200){
        value.data.forEach((element) {
          data.add(Adv_type_vo.fromJson(element));
        });
        notifyListeners();
      }
    });
  }


  void addAdvType(String typeName){
    HttpProxy.httpProxy.get(Api.addAdvType,parameters: {'typeName':typeName}).then((value) {
      if(value.code == 200){
        data.insert(0,Adv_type_vo.fromJson(value.data));
        notifyListeners();
      }
    });
  }

  void offType(int index,int status){
    HttpProxy.httpProxy.get(Api.offAdvType,parameters: {'advTypeId':data[index].id,'status':status}).then((value) {
      if(value.code == 200){
        data[index].status = status;
        notifyListeners();
      }
    });
  }
}