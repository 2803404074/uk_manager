
import 'package:flutter/material.dart';
import 'package:uk_manager/router/main_routers.dart';

import '../bean/user.dart';

class EduListPage extends StatefulWidget {
  const EduListPage({Key? key}) : super(key: key);

  @override
  _EduListPageState createState() => _EduListPageState();
}

class _EduListPageState extends State<EduListPage> with AutomaticKeepAliveClientMixin {
  List<User> _data = [];

  bool sortAscending = false;
  @override
  void initState() {
    List.generate(100, (index) {
      _data.add(User('土豪$index', index % 50, index % 2 == 0 ? '男' : '女'));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      child: PaginatedDataTable(
        sortColumnIndex: 2,
        sortAscending: sortAscending,
        header: Text('私教申请管理'),
        columns: [
          DataColumn(label: Text('用户')),
          DataColumn(label: Text('申请类型')),
          DataColumn(label: Text('申请时间'),onSort: (index,check){
            setState(() {
              sortAscending = check;
            });
          }),
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
  final List<User> data;
  MyDataTableSource(this.data,this.context);



  @override
  DataRow getRow(int index) {

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${data[index].name}')),
        DataCell(Text('${data[index].sex}')),
        DataCell(Text('${data[index].age}')),
        DataCell(Text('${data[index].age}')),
        DataCell(SizedBox(
          width: 300,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  child: Text('通过'),
                  onPressed: (){
                  },
                ),
                MaterialButton(
                  child: Text('不通过'),
                  onPressed: (){
                  },
                ),
                MaterialButton(
                  child: Text('详情'),
                  onPressed: (){
                    Navigator.pushNamed(context, MainRouter.eduDetailsPage,arguments: {'eId':12});
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

