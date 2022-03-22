

import 'package:flutter/material.dart';
import 'package:uk_manager/router/main_routers.dart';

import '../../../utils/dialog_util.dart';
import '../../edu/bean/user.dart';

class AdvDetailsPage extends StatefulWidget {
  final int tId;

  const AdvDetailsPage({Key? key,required this.tId}) : super(key: key);

  @override
  _AdvDetailsPageState createState() => _AdvDetailsPageState();
}

class _AdvDetailsPageState extends State<AdvDetailsPage> {


  final List<User> _data = [];

  bool sortAscending = false;


  @override
  void initState() {
    List.generate(10, (index) {
      _data.add(User('土豪$index', index % 50, index % 2 == 0 ? '男' : '女'));
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        sortColumnIndex: 2,
        sortAscending: sortAscending,
        header: Text('首页广告管理'),
        actions: [
          TextButton.icon(onPressed: (){
            Navigator.pushNamed(context, MainRouter.advAddEditPage);
          }, icon: Icon(Icons.add), label: Text('添加广告'))
        ],
        columns: [
          DataColumn(label: Text('id')),
          DataColumn(label: Text('封面')),
          DataColumn(label: Text('标题'),onSort: (index,check){
            setState(() {
              sortAscending = check;
            });
          }),
          DataColumn(label: Text('链接'),),
          DataColumn(label: Text('点击次数'),),
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

}

class MyDataTableSource extends DataTableSource {

  BuildContext context;
  MyDataTableSource(this.data,this.context);

  final List<User> data;

  @override
  DataRow getRow(int index) {

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${data[index].name}')),
        DataCell(Text('${data[index].sex}')),
        DataCell(Text('${data[index].age}')),
        DataCell(Text('${data[index].age}')),
        DataCell(Text('${data[index].age}')),
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
    return data.length;
  }
}
