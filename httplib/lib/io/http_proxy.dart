import 'package:dio/src/cancel_token.dart';
import 'package:dio/src/options.dart';
import 'package:httplib/base/base_res.dart';
import 'package:httplib/view/i_view.dart';

import 'i_http_proxy.dart';

///作者：黄仕豪
///时间：2021
/// 此类为功能代理
///
class HttpProxy implements IHttpProxy {
  ///需要代理的对象
  late IHttpProxy _iHttpProxy;

  ///静态当前实例对象，用于使用单例模式
  static HttpProxy? _httpProxy;

  ///创建私有的构造方法，仅供当前类使用 避免外部初始化
  HttpProxy._internal();

  ///由于dart为单线程模型，所有代码均运行在同一个isolate中
  ///这里不考虑线程安全的创建方式
  static HttpProxy get httpProxy {
    _httpProxy ??= HttpProxy._internal();
    return _httpProxy!;
  }

  ///初始化请求model
  void init(IHttpProxy proxy) {
    _iHttpProxy = proxy;
  }

  ///抽象取消请求
  @override
  void cancelRequests({CancelToken? cancelToken}) {
    _iHttpProxy.cancelRequests(cancelToken: cancelToken);
  }

  ///抽象get请求
  @override
  Future<BaseRes> get(String path,
      {Options? options,
      Map<String, dynamic>? parameters,
        Function(String message)? errCallBack,
      CancelToken? cancelToken}) {
    return _iHttpProxy.get(path,
        options: options, parameters: parameters, cancelToken: cancelToken);
  }

  ///抽象post请求
  @override
  Future<BaseRes> post(
    String path, {
    required Map<String, dynamic> parameters,
    Options? options,
    CancelToken? cancelToken,
        Function(String message)? errCallBack,
    bool? jsonRequest = false,

    Function(int progress, int total)? onSendProgress,
  }) {
    return _iHttpProxy.post(path,
        parameters: parameters,
        options: options,
        cancelToken: cancelToken,
        jsonRequest: jsonRequest);
  }

  ///抽象download请求
  @override
  Future<BaseRes> download(String path,
      {required String dir,
      Map<String, dynamic>? parameters,
      Options? options,
      CancelToken? cancelToken,
      Function(int received, int total)? onReceiveProgress}) {
    return _iHttpProxy.download(path,
        dir: dir,
        parameters: parameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }

  ///抽象changeBaseUrl
  @override
  void changeBaseUrl(String url) {
    _iHttpProxy.changeBaseUrl(url);
  }

  ///抽象设置请求view
  @override
  void setIView(IView iView) {
    _iHttpProxy.setIView(iView);
  }

  ///抽象是否采用请求view
  @override
  void enableDialog(bool enable) {
    _iHttpProxy.enableDialog(enable);
  }

}
