import 'package:comment/bean/res/curriculum_vo.dart';
import 'package:comment/const/api.dart';
import 'package:flutter/material.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/provider/base_model.dart';
import 'package:uk_manager/router/main_routers.dart';
import 'package:uk_manager/utils/dialog_util.dart';
import 'package:uk_manager/widget/u_image.dart';

class CuListPage extends StatefulWidget {
  final String? title;
  final int? id;

  const CuListPage({Key? key, required this.title, required this.id})
      : super(key: key);

  @override
  _CuListPageState createState() => _CuListPageState();
}

class _Model extends BaseModel {
  var mList = <CurriculumVo>[];

  int? modularId;

  _Model(BuildContext context, {this.modularId}) : super(context) {
    getData();
  }

  void getData() async {
    HttpProxy.httpProxy.get(
        Api.curriculumModularList, parameters: {'modularId': modularId}).then((
        value) {
      if (value.code == 200) {
        value.data.forEach((element) {
          mList.add(CurriculumVo.fromJson(element));
        });
        success();
      } else {
        err(str: value.message);
      }
    }).onError((error, stackTrace) {
      err(str: error.toString());
    });
  }

  void remove(
      {required int index, required bool add}) {
    var vo = mList[index];
    HttpProxy.httpProxy.post(Api.addAndRemoveModularCurriculum, parameters: {
      'modularId': modularId,
      'curriculumId': vo.id,
      'tag': add ? 0 : 1
    }).then((value) {
      DialogUtil.getInstance().showMessageAlertDialog(context, value.message, [
        ActionTextItem('确定')
      ]);
      if(value.code == 200){
        mList.removeAt(index);
        notifyListeners();
      }
    }).onError((error, stackTrace) {

    });
  }
}

class _CuListPageState extends State<CuListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _Model(context, modularId: widget.id),
      child: Consumer<_Model>(builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text(widget.title ?? ''),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, MainRouter.curriculumPage);
                    },
                    icon: Icon(Icons.add),
                    label: Text('添加课程'))
              ],
            ),
            body: model.status == LoadStatus.loading ?
            Center(child: DialogUtil.getInstance().loadingView(),) :
            model.mList.isEmpty ? const Center(
              child: Text('该模块没有课程',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ) :

            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: model.mList.length,
              itemBuilder: (context, index) {
                var vo = model.mList[index];
                return Row(
                  children: [
                    UImage('${vo.cover}',
                      mHeight: 80,
                      mWidth: 80,
                    ),
                    const SizedBox(width: 5,),
                    SizedBox(height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${vo.title}', style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),),

                          Text('${vo.introduce}',
                            style: const TextStyle(fontSize: 14),),

                          Text('添加时间:${vo.updatedAt}')

                        ],
                      ),),
                    const Expanded(child: SizedBox()),
                    MaterialButton(onPressed: () {
                      DialogUtil.getInstance().showMessageAlertDialog(
                          context, '移除后首页推荐将看不到该课程，是否继续？', [
                        ActionTextItem('确定', clickCallBack: () {
                          model.remove(index: index, add: false);
                        }),
                      ]);
                    }, child: const Text('移除'),)
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(height: 20, thickness: 1,);
              },)
        );
      },),
    );
  }
}
