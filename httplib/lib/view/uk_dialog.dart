import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:httplib/view/i_view.dart';

///
/// 网络请求过程中，UI怎么展示
/// 这个是实际的操作
/// 如果你想要其它的样式，请继承Iview。继承后，请求直接生效。
class UkDialog extends IView {
  ///静态当前实例对象，用于使用单例模式
  static UkDialog? _instance;

  ///创建私有的构造方法，仅供当前类使用 避免外部初始化
  UkDialog._internal(BuildContext context) {
    mContext = context;
  }

  ///由于dart为单线程模型，所有代码均运行在同一个isolate中
  ///这里不考虑线程安全的创建方式
  static UkDialog getInstance(BuildContext context) {
    _instance ??= UkDialog._internal(context);
    return _instance!;
  }

  late BuildContext mContext;

  void _showLoadDialog() {
    showDialog(
        context: mContext,
        //barrierDismissible: false,
        builder: (context) {
          return Dialog(//想控制宽度，在外面套一层 UnconstrainedBox
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:  [
                Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: const CircularProgressIndicator(),
                ),
                const Text('正在加载中...'),
                const SizedBox(height: 20,),
              ],
            ),
          );
        });
  }

  void _showErrDialog({String? str}) {
    showDialog(
        context: mContext,
        //barrierDismissible: false,
        builder: (context) {
          return Dialog(//想控制宽度，在外面套一层 UnconstrainedBox
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:  [
                Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: const Icon(Icons.priority_high,color: Colors.red,size: 30,),
                ),
                Text(str??'加载失败...'),
                const SizedBox(height: 20,),
              ],
            ),
          );
        });
  }

  @override
  void dismiss() {
    Navigator.pop(mContext);
  }

  @override
  void err({String? errStr}) {
    Navigator.pop(mContext);
    _showErrDialog(str: errStr);
  }

  @override
  void loading({double? progress}) {
    _showLoadDialog();
  }
}
