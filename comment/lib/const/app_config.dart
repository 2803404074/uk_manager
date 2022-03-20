

import 'dart:developer';

import 'package:flutter/foundation.dart';

class BuildConfig{
  static const DEBUG = true;
  //static const DEV_URL = 'http://118.31.229.127:8091/api/';
  static const DEV_URL = 'http://192.168.42.145:8091/api/';
  static const PRO_URL = 'http://tuhaolili.top/';
  static const QN_URL = 'http://tuhaolili.top/';
  static const nimKey = '9d9090599c2a191186b7f3be790083ef';

  static const defaultCover = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic.jkjianfei.com%2Fjianfei_images%2Fwithsqz.jpeg&refer=http%3A%2F%2Fpic.jkjianfei.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1645713980&t=644cd21bc85a043615d20225ff1dfc2d';

  static const BASE_RUL = DEV_URL;

  static void println(String str,{String? tag}){
    if(DEBUG){
      log('===== ${tag??''} =======>>>>>$str \n\n');
    }
  }
}