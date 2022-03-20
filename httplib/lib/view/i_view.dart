

///你可以自定义其它操作
///他是抽象请求过程中，UI怎么展示
abstract class IView{
  void loading({double? progress});
  void dismiss();
  void err({String? errStr});
}