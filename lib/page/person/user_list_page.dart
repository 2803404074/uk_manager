import 'dart:convert';
import 'dart:developer';

import 'package:comment/const/api.dart';
import 'package:flutter/material.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/provider/base_model.dart';
import 'package:comment/bean/res/user_vo.dart';

import '../../widget/base_view.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _Model(context),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Selector<_Model, int>(
                builder: (context, value, child) {
                  var model = context.read<_Model>();
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Text('过滤条件: ',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 16,height: 1),),
                          ...model.parList.map((e) {
                            return ActionChip(
                              label: Text('${e.name}'),
                              avatar: e.check ? const Icon(Icons.check) : null,
                              onPressed: () {
                                model.clickLabel(e);
                              },
                            );
                          }).toList()
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: TextField(
                                onChanged: (value) {
                                  model.parameters['likeName'] = value;
                                },
                                decoration: baseInputDecoration(hint: '用户昵称')
                            ),
                          ),
                          MaterialButton(
                            onPressed: (){
                              model.loadData();
                            },child: const Text('搜索'),color: Colors.blue,textColor: Colors.white,)
                        ],
                      )
                    ],
                  );
                },
                selector: (context, model) => model.clickIndex),

            Selector<_Model,int?>(builder: (context,value,child){
              var list = context.read<_Model>().userList;
              if(value==null || value.isNaN){
                return const SizedBox();
              }
              return ListView(
                shrinkWrap: true,
                children: List.generate(value, (index){
                  var vo = list![index];
                  return Row(
                    children: [
                      Text('${vo.nickName}')
                    ],
                  );
                }),
              );

            }, selector: (context,model)=>model.userList?.length)
          ],
        ),
      ),
    );
  }
}

class _Model extends BaseModel {
  List<UserVo>? userList;
  var parameters = {
    'news':'',
    'vip':false,
    'edu':false,
    'today':false,
  };

  var parList = [
    _Vo('最新注册', 'news'),
    _Vo('私教用户', 'vip'),
    _Vo('vip用户', 'edu'),
    _Vo('今日注册', 'today'),
  ];
  var clickIndex = 0;

  _Model(BuildContext context) : super(context);

  void clickLabel(_Vo vo) {
    vo.check = !vo.check;
    parameters['${vo.value}'] = vo.check;
    clickIndex++;
    notifyListeners();
    page = 1;
    loadData();
  }

  void loadData({bool loadMore = false}) {
    setLoadMore(loadMore);

    parameters['page'] = page;
    log('请求参数:$parameters');
    HttpProxy.httpProxy
        .post(Api.userList, parameters: parameters,jsonRequest: true)
        .then((value) {
      if (value.code==200) {
        var records = value.data['records'];
        List<UserVo> list=[];
        records.forEach((element) {
          list.add(UserVo.fromJson(element));
        });
        userList = list;
        notifyListeners();
      } else {}
    }).onError((error, stackTrace) {});
  }
}

class _Vo {
  String? name;
  String? key;
  String? value;
  bool check;

  _Vo(this.name, this.key, {this.check = false, this.value});
}
