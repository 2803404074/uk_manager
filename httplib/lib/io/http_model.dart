import 'dart:convert';
import 'dart:typed_data';

import 'package:comment/const/app_config.dart';
import 'package:dio/dio.dart';
import 'package:httplib/base/base_res.dart';
import 'package:httplib/view/i_view.dart';
import 'dio_interceptor.dart';
import 'i_http_proxy.dart';

///作者：黄仕豪
///时间：2021
///使用代理模式封装请求库
/// 此类为真正的网络实现
///
class HttpModel with IHttpProxy {
  ///静态当前实例对象，用于使用单例模式
  static HttpModel? _instance;

  ///创建私有的构造方法，仅供当前类使用 避免外部初始化
  HttpModel._internal() {
    _init();
  }

  ///由于dart为单线程模型，所有代码均运行在同一个isolate中
  ///这里不考虑线程安全的创建方式
  static HttpModel get instance {
    _instance ??= HttpModel._internal();
    return _instance!;
  }

  late Dio _dio;


  IView? _iView;

  bool isEnableDialog = false;

  void _init() {
    _dio = Dio();
    final baseOptions = BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 5000,
        sendTimeout: 5000,
        responseType: ResponseType.json,
        baseUrl: BuildConfig.BASE_RUL,
        validateStatus: (statues) {
          // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
          return true;
        });
    _dio.options = baseOptions;
    _dio.interceptors.add(DioInterceptor());

    ///初始化网络代理
    BuildConfig.println('初始化网络请求代理-------');
  }


  BaseRes _fetchSuccessEvent(dynamic resData){
    var data = BaseRes.fromJson(resData);
    if(isEnableDialog) {
      _iView?.dismiss();
      isEnableDialog = false;
    }
    return data;
  }

  void _fetchErrEvent(dynamic error){
    if(isEnableDialog) {
      _iView?.err(errStr: error.toString());
      isEnableDialog = false;
    }
  }

  @override
  void cancelRequests({CancelToken? cancelToken}) {
    cancelToken?.cancel();
  }

  @override
  Future<BaseRes> get(
    String path, {
    Options? options,
    Map<String, dynamic>? parameters,
        Function(String message)? errCallBack,
    CancelToken? cancelToken,
  }) {

    if(isEnableDialog) {
      _iView?.loading();
    }
    return _dio
        .get(path,
            queryParameters: parameters,
            options: options,
            cancelToken: cancelToken)
        .then((value) {
      return _fetchSuccessEvent(value.data);
    }).onError((error, stackTrace) {
      _fetchErrEvent('请稍后再试');
      errCallBack?.call(error?.toString()??'');
      return Future.error(error?.toString() ?? '');
    });
  }

  @override
  Future<BaseRes> post(
    String path, {
    required Map<String, dynamic> parameters,
    Options? options,
    CancelToken? cancelToken,
    bool? jsonRequest,
        Function(String message)? errCallBack,
    Function(int progress, int total)? onSendProgress,
  }) {
    print('表单请求11111');
    if(isEnableDialog) {
      _iView?.loading();
    }
    Object map;
    if (jsonRequest == null || !jsonRequest) {
      map = FormData.fromMap(parameters);
      print('表单请求');
    } else {
      print('表单请求2222');
      map = json.encode(parameters);
    }
    return _dio.post(path,
        data: map,
        options: options,
        cancelToken: cancelToken, onSendProgress: (int progress, int total) {
      onSendProgress?.call(progress, total);
    }).then((value) {
      return _fetchSuccessEvent(value.data);
    }).onError((error, stackTrace) {
      _fetchErrEvent(error);
      errCallBack?.call(error?.toString()??'');
      print('错误:${error.toString()}');
      return Future.error(error?.toString() ?? '');
    });
  }

  @override
  Future<BaseRes> upload(String path, {required Uint8List uInt8list})async {
    var map = FormData.fromMap({
      'file':MultipartFile.fromBytes(uInt8list),
    });
    try{
      var response = await _dio.post(path, data: map);
      return  _fetchSuccessEvent(response.data);
    }catch(e){
      return BaseRes(data:'',message: e.toString(),code: -1);
    }
  }

  @override
  Future<BaseRes> download(String path,
      {required String dir,
      Map<String, dynamic>? parameters,
      Options? options,
      CancelToken? cancelToken,
      Function(int received, int total)? onReceiveProgress}) {
    _iView?.loading();
    return _dio.download(path, dir, options: options, cancelToken: cancelToken,
        onReceiveProgress: (int received, int total) {
      if (total != -1) {
        ///当前下载的百分比例
        //BuildConfig.println((received / total * 100).toStringAsFixed(0) + "%");
      }
      onReceiveProgress?.call(received, total);
    }).then((value) {
      return _fetchSuccessEvent(value.data);
    }).onError((error, stackTrace) {
      _fetchErrEvent(error);
      return Future.error(error?.toString() ?? '');
    });
  }

  @override
  void changeBaseUrl(String url){
    _dio.options.baseUrl = url;
  }

  @override
  void setIView(IView? iView) {
    _iView = iView;
  }

  @override
  void enableDialog(bool enable) {
    isEnableDialog = enable;
  }


}
