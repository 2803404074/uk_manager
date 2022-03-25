

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/page/adv/model/adv_model.dart';
import 'package:uk_manager/router/main_routers.dart';
import 'package:uk_manager/widget/u_image.dart';
import '../../edu/bean/user.dart';

class AdvDetailsPage extends StatefulWidget {
  final int tId;
  final String tName;
  const AdvDetailsPage({Key? key,required this.tId,required this.tName}) : super(key: key);

  @override
  _AdvDetailsPageState createState() => _AdvDetailsPageState();
}

class _AdvDetailsPageState extends State<AdvDetailsPage> {

  @override
  void initState() {
    super.initState();
  }


  Widget titleView(String str){
    return Text(str);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ChangeNotifierProvider(create: (context)=>AdvModel(context,widget.tId),child: Consumer<AdvModel>(
        builder: (context,model,child){
          return PaginatedDataTable(
            dataRowHeight: 100,
            header: Text(widget.tName),
            actions: [
              TextButton.icon(onPressed: (){
                Navigator.pushNamed(context, MainRouter.advAddEditPage,arguments: {'model':model});
              }, icon: const Icon(Icons.add), label: const Text('添加广告'))
            ],
            columns:  [
              DataColumn(label: titleView('id')),
              DataColumn(label: titleView('类型'),),
              DataColumn(label: titleView('发布时间'),),
              DataColumn(label: titleView('封面')),
              DataColumn(label: titleView('标题')),
              DataColumn(label: titleView('链接'),),
              DataColumn(label: titleView('点击次数'),),
              DataColumn(label: titleView('状态'),),
              DataColumn(label: SizedBox(
                width: 300,
                child: Center(
                  child: Text('操作'),
                ),
              ),numeric: true),
            ],
            source: MyDataTableSource(model,context),
          );
        },
      ),),
    );

  }

}

class MyDataTableSource extends DataTableSource {

  AdvModel advModel;
  BuildContext context;
  MyDataTableSource(this.advModel,this.context);


  @override
  DataRow getRow(int index) {
    var data = advModel.data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${data.id}')),
        DataCell(Text(data.local == 0?'本地广告':'第三方广告')),
        DataCell(Text('${data.createdAt}')),
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: AspectRatio(
              aspectRatio: 9/16,
              child: UImage('${data.cover}'),
            ),
          )
        ),
        DataCell(Text('${data.title}')),
        DataCell(Text('${data.linkUrl}')),
        DataCell(Text('${data.clickNum??0}')),
        DataCell(Text(data.status == 0?'正常':'已下线',style: TextStyle(color: data.status == 0?Colors.green:Colors.grey),)),
        DataCell(SizedBox(
          width: 300,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  child: const Text('修改'),
                  onPressed: (){
                    Navigator.pushNamed(context, MainRouter.advAddEditPage,arguments: {'model':advModel,'vo':data});
                  },
                ),
                MaterialButton(
                  child: Text(data.status == 0?'下线':'上线'),
                  onPressed: (){
                    advModel.offAdv(index,data.status == 0?1:0);
                  },
                ),
              ],
            ),
          ),
        ),),
      ],
    );
  }

  @override
  int get selectedRowCount {
    return 0;
  }

  @override
  bool get isRowCountApproximate {
    return false;
  }

  @override
  int get rowCount {
    return advModel.data.length;
  }
}
