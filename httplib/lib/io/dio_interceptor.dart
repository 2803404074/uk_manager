

import 'dart:convert';

import 'package:comment/const/app_config.dart';
import 'package:dio/dio.dart';
import 'package:httplib/io/requst_exceptions.dart';
import 'package:httplib/io/token_help.dart';
///
/// 自定义拦截器
class DioInterceptor extends InterceptorsWrapper{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /// 在这里，你可以添加请求前添加token，加密，解密等操作
    var nowToken = TokenHelp.getInstance().getToken();

    var token = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhdXRoIiwiVVNFUl9JRCI6MTUsIlVTRVJfTkFNRSI6Iumfs-S5kOmYn-mVv--8jemYv-acqOacqCIsImV4cCI6MTY1MTMxMzUzNSwiaWF0IjoxNjQ4NzIxNTM1fQ.ysUmw8BurEgnbiTAkkhBFeavqxBSfSBsAHNiit_Fsgo3uiuvbE2fIsyd7bEPPCGIDk_ZZYJvzeh_FpKFQSpgfQ";
    BuildConfig.println('token====>$nowToken',tag: 'request');
    options.headers.addAll({'Authorization':token});
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var path = err.requestOptions.path;
    var appException = RequestException.create(err);
    err.error = appException;
    BuildConfig.println('========>>>>>>>onRequestPath:$path');
    BuildConfig.println('========>>>>>>>onError:${err.message}');
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var path = response.requestOptions.path;
    var data = response.data;
    var statusCode = response.statusCode;
    if(statusCode != 200){
      var dio = DioError(requestOptions: response.requestOptions,type: DioErrorType.connectTimeout);
      RequestException.create(dio);
      handler.reject(dio);
    }else{
      BuildConfig.println('========>>>>>>>onRequestPath:$path');
      BuildConfig.println('========>>>>>>>onResponseData:${data.toString()}');
      super.onResponse(response, handler);
    }
  }

}