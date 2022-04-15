import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/page/edu/model/edu_model.dart';
import 'package:uk_manager/router/main_routers.dart';

import '../bean/user.dart';

class EduListPage extends StatefulWidget {
  const EduListPage({Key? key}) : super(key: key);

  @override
  _EduListPageState createState() => _EduListPageState();
}

class _EduListPageState extends State<EduListPage>with AutomaticKeepAliveClientMixin {
  bool sortAscending = false;

  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider(
      create: (context) => EduModel(context),
      child: SingleChildScrollView(
        child: Consumer<EduModel>(
          builder: (context, model, child) {
            return PaginatedDataTable(
              sortColumnIndex: 2,
              sortAscending: sortAscending,
              header: Text('私教申请管理'),
              columns: [
                DataColumn(label: Text('用户')),
                DataColumn(label: Text('申请类型')),
                DataColumn(
                    label: Text('申请时间'),
                    onSort: (index, check) {
                      setState(() {
                        sortAscending = check;
                      });
                    }),
                DataColumn(
                  label: Text('状态'),
                ),
                DataColumn(
                    label: SizedBox(
                      width: 300,
                      child: Center(
                        child: Text('操作'),
                      ),
                    ),
                    numeric: true),
              ],
              source: MyDataTableSource(model, context),
            );
          },
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


}

class MyDataTableSource extends DataTableSource {
  BuildContext context;
  EduModel model;

  MyDataTableSource(this.model, this.context);

  @override
  DataRow getRow(int index) {
    var data = model.data;
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${data[index].nickName}')),
        DataCell(Text(data[index].applicationType == 0?'个人':'机构')),
        DataCell(Text('${data[index].createdAt}')),
        DataCell(Text(data[index].status == 0?'未审批':data[index].status == 1?'通过':'未通过')),
        DataCell(
          SizedBox(
            width: 300,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(data[index].status == 0 || data[index].status == 2)
                    MaterialButton(
                      child: Text('通过'),
                      onPressed: () {
                        model.pass(index, 1);
                      },
                    ),
                  if(data[index].status == 0 || data[index].status == 1)
                    MaterialButton(
                      child: Text('不通过'),
                      onPressed: () {
                        model.pass(index, 2);
                      },
                    ),
                  MaterialButton(
                    child: Text('详情'),
                    onPressed: () {
                      Navigator.pushNamed(context, MainRouter.eduDetailsPage,
                          arguments: {'eId': data[index].id,'index':index,'model':model});
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
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
    return model.data.length;
  }
}
