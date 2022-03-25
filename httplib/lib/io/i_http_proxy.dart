import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:httplib/base/base_res.dart';
import 'package:httplib/view/i_view.dart';

///作者：黄仕豪
///时间：2021
///使用代理模式封装请求库
/// 此类为抽象代理抽象
/// 这里我用通俗易懂的方式解说下：
///             代理人和被代理人都需要分别继承抽象代理
///             因为代理人需要知道被代理的人想要什么样的服务
///             因为被代理人要知道代理人能提供什么样的服务
///             细细品上面这两句话，在实际开发中。理解后你可以运用到需要代理的业务逻辑
///
abstract class IHttpProxy {

  void setIView(IView iView);

  void enableDialog(bool enable);

  void cancelRequests({CancelToken? cancelToken,});

  Future<BaseRes> get(
      String path,
      {
      Options? options,
      Map<String, dynamic>? parameters,
        Function(String message)? errCallBack,
      CancelToken? cancelToken});

  Future<BaseRes> post(
      String path,
      {
    required Map<String, dynamic> parameters,
    Options? options,
    CancelToken? cancelToken,
    bool? jsonRequest = false,
        Function(String message) errCallBack,
    Function(int progress,int total)? onSendProgress,
  });


  Future<BaseRes> download(
      String path,
      {
    required String dir,
    Map<String, dynamic>? parameters,
    Options? options,
    CancelToken? cancelToken,
    Function(int received,int total)? onReceiveProgress,
  });

  Future<BaseRes> upload(
      String path,
      {
        required Uint8List uInt8list,
      });

  void changeBaseUrl(String url);

}
