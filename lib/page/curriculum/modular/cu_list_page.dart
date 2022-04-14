
import 'package:flutter/material.dart';
import 'package:uk_manager/router/main_routers.dart';

class  CuListPage extends StatefulWidget {
  final String? title;
  final int? id;
  const CuListPage({Key? key,required this.title,required this.id}) : super(key: key);

  @override
  _CuListPageState createState() => _CuListPageState();
}

class _CuListPageState extends State< CuListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title??''),
        actions: [
          TextButton.icon(onPressed: (){
            Navigator.pushNamed(context, MainRouter.curriculumPage);
          }, icon: Icon(Icons.add), label: Text('添加课程'))
        ],
      ),
      body: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 16/9,
        shrinkWrap: true,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        padding: const EdgeInsets.all(15),
        children: List.generate(50, (index) {
          return Stack(
            children: [
              Container(color: Colors.red,),
              Container(color: Colors.black26,),
              Align(
                alignment: Alignment.topRight,
                child: MaterialButton(onPressed: (){

                },color: Colors.white54,textColor: Colors.red,child: const Text('移除'),),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  color: Colors.black,
                  child: Text('瑜伽',style: TextStyle(color: Colors.white),),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  child: Text('移除移除移除移除移除移除移除移除移除移除',style: TextStyle(color: Colors.white),),
                  color: Colors.black54,
                ),
              ),


            ],
          );
        }),
      ),
    );
  }
}
