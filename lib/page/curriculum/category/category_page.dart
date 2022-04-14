

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/page/curriculum/category/CategoryModel.dart';
import 'package:uk_manager/provider/base_model.dart';
import 'package:uk_manager/utils/dialog_util.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>CategoryModel(context),
    child: Scaffold(
      appBar: AppBar(
        title: const Text('课程分类'),
      ),
      body: Consumer<CategoryModel>(
        builder: (context,model,child){
          if(model.status == LoadStatus.loading){
            return Center(
              child: DialogUtil.getInstance().loadingView(),
            );
          }
          if(model.status == LoadStatus.err){
            return Center(
              child: Text(model.errStr??''),
            );
          }

          return ListView(

          );


        },
      )
    ),
    );
  }
}
