
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/page/curriculum/modular/modular_model.dart';
import 'package:uk_manager/provider/base_model.dart';
import 'package:uk_manager/router/main_routers.dart';
import 'package:uk_manager/utils/dialog_util.dart';

class CurriculumModularPage extends StatefulWidget {
  const CurriculumModularPage({Key? key}) : super(key: key);

  @override
  _CurriculumModularPageState createState() => _CurriculumModularPageState();
}

class _CurriculumModularPageState extends State<CurriculumModularPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => ModularModel(context),
      child: Consumer<ModularModel>(builder: (context, model, child) {
        return judgeWidget(context,model);
      }),
    );
  }

  Widget judgeWidget(BuildContext context,ModularModel model) {
    if (model.status == LoadStatus.loading) {
      return Center(
        child: DialogUtil.getInstance().loadingView(),
      );
    }
    if (model.status == LoadStatus.err) {
      return Center(
          child: Container(
            width: 100,
            height: 50,
            color: Colors.grey[200],
            child: Text('加载失败：${model.errStr}'),
          ));
    }
    return Column(
      children: [
        InkWell(
          onTap: (){
            DialogUtil.getInstance().showInputAlertDialog(context, '', (inputText){

            },callBack2: (v1,v2){
              model.add(v1, int.parse(v2));
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.green
            ),
            child: const Text('添加模块',style: TextStyle(fontSize: 25,color: Colors.white),),
          ),
        ),
        Expanded(child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 5),
          children: List.generate(model.modularList.length, (index) {
            var data = model.modularList[index];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              margin: const EdgeInsets.symmetric(vertical:5,horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]
              ),
              child: Row(
                children: [

                  Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[400]
                    ),
                    alignment: Alignment.center,
                    child: Text('${index+1}',style: TextStyle(color: Colors.grey[600]),),
                  ),

                  Text('${data['title']}',style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                  const Text('  ------  ',style: TextStyle(color: Colors.black54),),
                  Text(data['status'] == 0?'正常':'已下线',style: TextStyle(color: data['status'] == 0?Colors.green:Colors.red,fontWeight: FontWeight.bold),),

                  const Text('  ------  ',style: TextStyle(color: Colors.black54),),
                  Text('app显示的位置:${data['type']}',style: const TextStyle(color: Colors.black87,fontSize: 18),),

                  const Expanded(child: SizedBox()),

                  const SizedBox(width: 10,),
                  MaterialButton(onPressed: () {
                    Navigator.pushNamed(context, MainRouter.cuListPage,arguments: {'id':data['id'],'title':data['title']});
                  }, child: const Text('课程列表',style: TextStyle(fontWeight: FontWeight.bold),),color: Colors.green,textColor: Colors.white,),


                  const SizedBox(width: 10,),
                  MaterialButton(onPressed: () {
                    var st = 0;
                    if(data['status'] == 0){
                      st = 1;
                    }else{
                      st = 0;
                    }
                    model.update(index,data['title'], data['type'],status: st);

                  }, child: Text(data['status'] == 0?'下线':'上线',style: const TextStyle(fontWeight: FontWeight.bold),),color: data['status'] == 0?Colors.red[300]:Colors.green,textColor: Colors.white,),

                  const SizedBox(width: 10,),
                  MaterialButton(onPressed: () {
                    DialogUtil.getInstance().showMessageAlertDialog(context,'删除后该模块下的视频将移除，是否继续?',[
                      ActionTextItem('取消'),
                      ActionTextItem('确定',clickCallBack: (){
                        model.delete(index);
                      }),
                    ]);
                  }, child: const Text('删除',),color: Colors.red,textColor: Colors.white,),
                  const SizedBox(width: 10,),
                  MaterialButton(onPressed: () {
                    DialogUtil.getInstance().showInputAlertDialog(context, data['title'], (inputText){

                    },callBack2: (v1,v2){
                      model.update(index,v1, int.parse(v2));
                    });
                  }, child: const Text('修改'),color: Colors.blue,textColor: Colors.white,),
                ],
              ),
            );
          }),
        ))
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

