

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/page/curriculum/category/CategoryModel.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  int num=0;

  void add(){


    for(int i=0;i<=100;i++){
      num+=i;
    }
















    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>CategoryModel(context),
    child: Scaffold(
      appBar: AppBar(
        title: const Text('课程分类'),
      ),
      floatingActionButton: TextButton(
        child: const Text('开始计算'),
        onPressed: (){
          add();
        },
      ),
      body: Center(
        child: Text('$num',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.red),),
      ),
    ),
    );
  }
}
