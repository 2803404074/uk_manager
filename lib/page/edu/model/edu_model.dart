
import 'package:flutter/material.dart';
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

  EduModel(BuildContext context) : super(context);

  void changeStatusIndex(int index){
    statusIndex = index;
    notifyListeners();
  }

  void changeTypeIndex(int index){
    typeIndex = index;
    notifyListeners();
  }

}