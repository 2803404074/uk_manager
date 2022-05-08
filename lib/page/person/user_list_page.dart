import 'dart:convert';
import 'dart:developer';

import 'package:comment/const/api.dart';
import 'package:flutter/material.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/provider/base_model.dart';
import 'package:comment/bean/res/user_vo.dart';
import 'package:uk_manager/utils/dialog_util.dart';
import 'package:uk_manager/widget/u_image.dart';

import '../../widget/base_view.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> with AutomaticKeepAliveClientMixin{


  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                      ),
                      const Divider(height: 20,thickness: 1,color: Colors.blue,),

                    ],
                  );
                },
                selector: (context, model) => model.clickIndex),

            Row(
              children:  const [
                Expanded(child: Text('基本信息',style: TextStyle(color: Colors.blue),)),
                Expanded(child: SizedBox()),
                SizedBox(
                  width: 200,
                  child: Center(child: Text('注册日期',style: TextStyle(color: Colors.blue),)),
                )
              ],
            ),
            const SizedBox(height: 10,),

            Expanded(child: Selector<_Model,int?>(builder: (context,value,child){
              var model = context.read<_Model>();
              var list = model.userList;

              if(value==null || value.isNaN){
                return const SizedBox();
              }
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    var vo = list![index];
                    return Row(
                      children: [
                        UImage('${vo.cover}',
                          mWidth: 60,
                          mHeight: 60,
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${vo.nickName}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                            const SizedBox(height: 5,),
                            Text(vo.hasVip == 1?'VIP用户':'普通用户')
                          ],
                        ),
                        const SizedBox(width: 10,),
                        if(vo.hasCoach == 1)
                          Container(
                            child: const Text('私教认证√',style: TextStyle(color: Colors.white),),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            margin: const EdgeInsets.only(right: 10),
                          ),

                        const Expanded(child: SizedBox()),
                        MaterialButton(onPressed: (){
                          DialogUtil.getInstance().showInputAlertDialog(context, '消息', (inputText){
                            model.sendMessage(message: inputText,uId: vo.id);
                          });
                        },child: const Text('发消息'),),
                        SizedBox(width: 200,child: Center(child: Text('${vo.createdAt}'),),)


                      ],
                    );
                  }, separatorBuilder: (context,index){
                return const Divider(height: 20,thickness: 5,);
              }, itemCount: value);

            }, selector: (context,model)=>model.userList?.length)),


          ],
        ),
      ),
    );
  }
}



class _Model extends BaseModel {
  List<UserVo>? userList;
  var parameters = <String,dynamic>{
    'news':false,
    'vip':false,
    'edu':false,
    'today':false,
  };

  var parList = [
    _Vo('最新注册', 'news',value: 'news'),
    _Vo('私教用户', 'edu',value: 'edu'),
    _Vo('vip用户', 'vip',value: 'vip'),
    _Vo('今日注册', 'today',value: 'today'),
  ];
  var clickIndex = 0;

  _Model(BuildContext context) : super(context){
    loadData();
  }

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
        print('长度:${records.length}');
        List<UserVo> list=[];

        records.forEach((element) {
          list.add(UserVo.fromJson(element));
        });
        userList = list;
        notifyListeners();
      } else {}
    }).onError((error, stackTrace) {});
  }

  void sendMessage({required String message,int? uId}){
    if(message.isEmpty)return;
    HttpProxy.httpProxy.post(Api.sendMessage, parameters: {'msg':message,'toUserId':uId}).then((value){
      DialogUtil.getInstance().showMessageAlertDialog(context, value.message, [
        ActionTextItem('确定')
      ]);
    }).onError((error, stackTrace){
      DialogUtil.getInstance().showErrDialog(context,errTips: error.toString());
    });
  }
}

class _Vo {
  String? name;
  String? key;
  String? value;
  bool check;

  _Vo(this.name, this.key, {this.check = false, this.value});
}
