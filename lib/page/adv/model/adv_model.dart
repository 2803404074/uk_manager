

import 'package:comment/const/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:uk_manager/page/adv/bean/adv_vo.dart';
import 'package:uk_manager/provider/base_model.dart';

class AdvModel extends BaseModel{
  int tId;

  List<Adv_vo> data=[];

  AdvModel(BuildContext context,this.tId) : super(context){
   getAdvList();
  }


  void getAdvList(){
    data.clear();
    HttpProxy.httpProxy.get(Api.getAdvList,parameters: {'advTypeId':tId}).then((value) {
      print('相应:${value.data}');
      if(value.code == 200){
        value.data.forEach((element) {
          data.add(Adv_vo.fromJson(element));
        });
        notifyListeners();
      }
    });
  }

  void offAdv(int index,int status){
    HttpProxy.httpProxy.post(Api.offAdv,parameters: {'advId':data[index].id,'status':status}).then((value) {
      print('相应:${value.data}');
      if(value.code == 200){
        data[index].status = status;
        notifyListeners();
      }
    });
  }

}