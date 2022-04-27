






import 'package:flutter/material.dart';

InputDecoration baseInputDecoration({String? hint}){
  return InputDecoration(
    isCollapsed: false,
    hintText: hint??'',
    border: InputBorder.none,
  );
}