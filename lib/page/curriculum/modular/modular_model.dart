import 'package:comment/const/api.dart';
import 'package:flutter/material.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:uk_manager/provider/base_model.dart';

class ModularModel extends BaseModel {
  List<dynamic> modularList = [];

  ModularModel(BuildContext context) : super(context) {
    getData();
  }

  void getData() async {
    HttpProxy.httpProxy.get(Api.allModular).then((value) {
      if (value.code == 200) {
        modularList = value.data;
        success();
      } else {
        err(str: value.message);
      }
    }).onError((error, stackTrace) {
      err(str: error.toString());
    });
  }

  void add(String title, int type) {
    loading();
    HttpProxy.httpProxy.post(Api.addModular,
        parameters: {'title': title, 'type': type}).then((value) {
      if (value.code == 200) {
        modularList.add(value.data);
        success();
      } else {
        err(str: value.message);
      }
    }).onError((error, stackTrace) {
      err(str: error.toString());
    });
  }

  void delete(int index) {
    loading();
    HttpProxy.httpProxy.get(Api.removeModular,
        parameters: {'id': modularList[index]['id']}).then((value) {
      if (value.code == 200) {
        modularList.removeAt(index);
        success();
      } else {
        err(str: value.message);
      }
    }).onError((error, stackTrace) {
      err(str: error.toString());
    });
  }

  void update(int index,String title, int type,{int? status}) {
    loading();
    HttpProxy.httpProxy.post(Api.updateModular,
        parameters: {
      'id':modularList[index]['id'],
      'title': title, 'type': type,'status':status??0}).then((value) {
      if (value.code == 200) {
        modularList[index] = value.data;
        success();
      } else {
        err(str: value.message);
      }
    }).onError((error, stackTrace) {
      err(str: error.toString());
    });
  }



}
