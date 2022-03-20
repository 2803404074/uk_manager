
import 'dart:convert';

import 'package:comment/const/app_config.dart';

///
/// 为什么不用泛型？
/// 1 效率
/// 2 响应的报文最终不就是字符串吗...
class BaseRes{
  int code=200;
  String message;
  dynamic data;

  BaseRes({required this.code,required this.message,required this.data});

  factory BaseRes.fromJson(dynamic jsonStr){
    try{
      return BaseRes(
        code: jsonStr['code'],
        message: jsonStr['message'],
        data: jsonStr['data'],
      );
    }catch(e){
      BuildConfig.println('------>>>> 解析 BaseRes 异常:${e.toString()}');
      throw Exception('解析异常:${e.toString()}');
    }
  }
}