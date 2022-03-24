

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
            columns: const [
              DataColumn(label: Text('id')),
              DataColumn(label: Text('类型'),),
              DataColumn(label: Text('发布时间'),),
              DataColumn(label: Text('封面')),
              DataColumn(label: Text('标题')),
              DataColumn(label: Text('链接'),),
              DataColumn(label: Text('点击次数'),),
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
        DataCell(Text('${data.local}')),
        DataCell(Text('${data.createdAt}')),
        DataCell(
          UImage('${data.cover}')
        ),
        DataCell(Text('${data.title}')),
        DataCell(Text('${data.linkUrl}')),
        DataCell(Text('${data.clickNum}')),
        DataCell(SizedBox(
          width: 300,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  child: const Text('修改'),
                  onPressed: (){
                    Navigator.pushNamed(context, MainRouter.advAddEditPage);
                  },
                ),
                MaterialButton(
                  child: const Text('下线'),
                  onPressed: (){
                  },
                ),
                MaterialButton(
                  child: const Text('删除'),
                  onPressed: (){
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
