import 'dart:developer';

import 'package:comment/const/api.dart';
import 'package:flutter/material.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/page/adv/bean/adv_type_vo.dart';
import 'package:uk_manager/page/adv/model/adv_type_model.dart';
import 'package:uk_manager/router/main_routers.dart';
import 'package:uk_manager/utils/dialog_util.dart';

import '../../edu/bean/user.dart';

class AdvListPage extends StatefulWidget {
  const AdvListPage({Key? key}) : super(key: key);

  @override
  _AdvListPageState createState() => _AdvListPageState();
}

class _AdvListPageState extends State<AdvListPage>
    with AutomaticKeepAliveClientMixin {
  void showAlerter(BuildContext context, AdvTypeModel model) {
    DialogUtil.getInstance().showInputAlertDialog(context, '首页', (inputText) {
      model.addAdvType(inputText);
    }, titles: '添加广告类型');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => AdvTypeModel(context),
      child: SingleChildScrollView(
        child: Consumer<AdvTypeModel>(builder: (context, model, child) {
          return PaginatedDataTable(
            header: const Text('广告管理'),
            actions: [
              TextButton.icon(
                  onPressed: () {
                    showAlerter(context, model);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('添加广告类型')),
            ],
            columns: const [
              DataColumn(label: Text('id')),
              DataColumn(label: Text('类型')),
              DataColumn(label: Text('创建时间')),
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
        }),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class MyDataTableSource extends DataTableSource {
  AdvTypeModel advModel;
  BuildContext context;

  MyDataTableSource(this.advModel, this.context);

  @override
  DataRow getRow(int index) {
    var data = advModel.data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${data.id}')),
        DataCell(Text('${data.typeName}')),
        DataCell(Text('${data.createAt}')),
        DataCell(Text(
          data.status == 0 ? '正常' : '已下线',
          style: TextStyle(color: data.status == 0 ? Colors.green : Colors.red),
        )),
        DataCell(
          SizedBox(
            width: 300,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (data.status == 0)
                    MaterialButton(
                      child: const Text('下线'),
                      onPressed: () {
                        advModel.offType(index, 1);
                      },
                    )
                  else
                    MaterialButton(
                      child: const Text('上线'),
                      onPressed: () {
                        advModel.offType(index, 0);
                      },
                    ),
                  MaterialButton(
                    child: const Text('详情'),
                    onPressed: () {
                      Navigator.pushNamed(context, MainRouter.advDetailsPage,
                          arguments: {'tId': data.id,'tName':data.typeName});
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
    return advModel.data.length;
  }
}
