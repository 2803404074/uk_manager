import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uk_manager/router/main_routers.dart';

class CurriculumIndex extends StatelessWidget {
  const CurriculumIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, MainRouter.categoryPage);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(Random().nextInt(250), Random().nextInt(250), Random().nextInt(250), 1)
            ),
            child: const Text('课程分类管理',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
          ),
        ),
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, MainRouter.curriculumModularPage);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(Random().nextInt(250), Random().nextInt(250), Random().nextInt(250), 1)
            ),
            child: const Text('首页推荐模块管理',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
          ),
        ),
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, MainRouter.curriculumPage);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(Random().nextInt(250), Random().nextInt(250), Random().nextInt(250), 1)
            ),
            child: const Text('课程审核',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
          ),
        ),
      ],
    );
  }
}
