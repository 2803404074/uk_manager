


import 'package:comment/const/api.dart';
import 'package:flutter/material.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:uk_manager/page/adv/bean/adv_type_vo.dart';
import 'package:uk_manager/router/main_routers.dart';
import 'package:uk_manager/utils/dialog_util.dart';

import '../../edu/bean/user.dart';

class AdvListPage extends StatefulWidget {
  const AdvListPage({Key? key}) : super(key: key);

  @override
  _AdvListPageState createState() => _AdvListPageState();
}

class _AdvListPageState extends State<AdvListPage> with AutomaticKeepAliveClientMixin{
  final List<Adv_type_vo> _data = [];

  @override
  void initState() {
    getData();
    super.initState();
  }


  void getData(){
    HttpProxy.httpProxy.get(Api.advTypeList).then((value) {
      if(value.code == 200){
        value.data.forEach((element) {
          _data.add(Adv_type_vo.fromJson(element));
        });
        setState(() {
        });
      }
    });
  }


  void addAdvType(String typeName){
    HttpProxy.httpProxy.get(Api.addAdvType,parameters: {'typeName':typeName}).then((value) {
      if(value.code == 200){
        setState(() {
          _data.add(Adv_type_vo.fromJson(value.data));
        });
      }
    });
  }
  void showAlerter(BuildContext context){
    DialogUtil.getInstance().showInputAlertDialog(context, '首页', (inputText){
      addAdvType(inputText);
    },titles: '添加广告类型');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: PaginatedDataTable(
        header: const Text('广告管理'),
        actions: [
          TextButton.icon(onPressed: (){
            showAlerter(context);
          }, icon: const Icon(Icons.add), label: const Text('添加广告类型'))
        ],
        columns: const [
          DataColumn(label: Text('id')),
          DataColumn(label: Text('类型')),
          DataColumn(label: Text('创建时间')),
          DataColumn(label: Text('状态'),),
          DataColumn(label: SizedBox(
            width: 300,
            child: Center(
              child: Text('操作'),
            ),
          ),numeric: true),
        ],
        source: MyDataTableSource(_data,context),
      ),
    );

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

class MyDataTableSource extends DataTableSource {

  BuildContext context;
  MyDataTableSource(this.data,this.context);

  final List<Adv_type_vo> data;

  @override
  DataRow getRow(int index) {

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${data[index].id}')),
        DataCell(Text('${data[index].typeName}')),
        DataCell(Text('${data[index].createAt}')),
        DataCell(Text(data[index].status == 0?'正常':'已下线',style: TextStyle(
          color: data[index].status == 0?Colors.green:Colors.red
        ),)),
        DataCell(SizedBox(
          width: 300,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(data[index].status == 0)
                  MaterialButton(
                    child: const Text('下线'),
                    onPressed: (){
                    },
                  )
                else
                  MaterialButton(
                    child: const Text('上线'),
                    onPressed: (){
                    },
                  ),
                MaterialButton(
                  child: const Text('详情'),
                  onPressed: (){
                    Navigator.pushNamed(context, MainRouter.advDetailsPage,arguments: {'tId':12});
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
    return data.length;
  }
}
