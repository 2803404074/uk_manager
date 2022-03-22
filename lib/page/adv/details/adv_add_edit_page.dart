

import 'package:flutter/material.dart';

class AdvAddEditPage extends StatefulWidget {

  const AdvAddEditPage({Key? key}) : super(key: key);

  @override
  _AdvAddEditPageState createState() => _AdvAddEditPageState();
}

class _AdvAddEditPageState extends State<AdvAddEditPage> {

  final titleStyle = const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加广告'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('广告封面',style: titleStyle,),
          Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            color: Colors.grey[200],
            child: Icon(Icons.add),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
            Text('广告类型:',style: titleStyle,),
              SizedBox(width: 10,),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: Text('本地'),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[200]
                  ),
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: Text('第三方'),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200]
                  ),
                ),
              ),
            ],
          ),


          SizedBox(height: 20,),
          Text('标题',style: titleStyle,),
          TextField(),

          SizedBox(height: 20,),
          Text('广告链接',style: titleStyle,),
          TextField(),




        ],
      ),
    );
  }
}
