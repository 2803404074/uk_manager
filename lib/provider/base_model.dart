
import 'package:flutter/material.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:httplib/view/uk_dialog.dart';

///页面状态枚举
enum LoadStatus {
  loading,
  success,
  err,
  noData,
}

class BaseModel extends ChangeNotifier {
  late BuildContext context;

  var page = 1;

  ///初始化网络轻重中dialog的代理
  BaseModel(this.context) {
    HttpProxy.httpProxy.setIView(UkDialog.getInstance(context));
  }

  bool hasDisPos = false;

  LoadStatus status = LoadStatus.loading;
  String? errStr;

  void success() {
    status = LoadStatus.success;
    notifyListeners();
  }

  void err({String? str}) {
    status = LoadStatus.err;
    errStr = str;
    notifyListeners();
  }

  void loading() {
    status = LoadStatus.loading;
    notifyListeners();
  }

  void noData() {
    status = LoadStatus.noData;
    notifyListeners();
  }

  void setLoadMore(bool loadMore) {
    loadMore ? page++ : page = 1;
  }
  @override
  void dispose() {
    hasDisPos = true;
    super.dispose();
  }
}
