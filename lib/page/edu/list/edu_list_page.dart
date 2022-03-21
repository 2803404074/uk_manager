

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/router/main_routers.dart';

import '../model/edu_model.dart';

class EduListPage extends StatefulWidget {
  const EduListPage({Key? key}) : super(key: key);

  @override
  _EduListPageState createState() => _EduListPageState();
}

class _EduListPageState extends State<EduListPage> with AutomaticKeepAliveClientMixin {

  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(create: (context) => EduModel(context),
      child: Column(
        children: [
          Selector<EduModel, int>(builder: (context, value, child) {
            var model = context.read<EduModel>();
            return Row(
              children: List.generate(model.statusList.length, (index) {
                return InkWell(
                  onTap: () {
                    model.changeStatusIndex(index);
                  },
                  child: Container(
                    child: Text(model.statusList[index]),
                    margin: const EdgeInsets.only(right: 10),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: value == index ? Colors.orange : Colors.grey),
                  ),
                );
              }),
            );
          }, selector: (context, model) => model.statusIndex),

          const SizedBox(height: 10,),
          Selector<EduModel, int>(builder: (context, value, child) {
            var model = context.read<EduModel>();
            return Row(
              children: List.generate(model.typeList.length, (index) {
                return InkWell(
                  onTap: () {
                    model.changeTypeIndex(index);
                  },
                  child: Container(
                    child: Text(model.typeList[index]),
                    margin: const EdgeInsets.only(right: 10),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: value == index ? Colors.orange : Colors.grey),
                  ),
                );
              }),
            );
          }, selector: (context, model) => model.typeIndex),

          const SizedBox(height: 10,),
          Expanded(child: Scrollbar(
            controller:controller ,
            child: ListView.separated(
                controller: controller,
                itemBuilder: (context,index){
              return Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    color: Colors.red,
                  ),
                  SizedBox(width: 5,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('昵称'),
                      Row(
                        children: [
                          Text('申请类型       申请时间       '),
                          Text('状态:'),
                          Text('已通过',style: TextStyle(color: Colors.green),),
                        ],
                      )

                    ],
                  ),
                  Spacer(),
                  MaterialButton(onPressed: (){

                  },child: Text('通过'),),
                  MaterialButton(onPressed: (){

                  },child: Text('不通过'),),
                  MaterialButton(onPressed: (){
                    Navigator.pushNamed(context, MainRouter.eduListDetailsPage,arguments: {'eId':1});
                  },child: Text('详情'),)
                ],
              );
            }, separatorBuilder: (context,index){
              return Divider(height: 20,thickness: 1,color: Colors.grey[200],);
            }, itemCount: 20),
          )),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200]
              ),
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text('共100页，当前第6页',style: TextStyle(fontSize: 18),),
            ),
          )


        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
