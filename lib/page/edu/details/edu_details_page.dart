
import 'package:flutter/material.dart';

class EduDetailsPage extends StatefulWidget {
  final int eId;
  const EduDetailsPage({Key? key,required this.eId}) : super(key: key);

  @override
  _EduDetailsPageState createState() => _EduDetailsPageState();
}

class _EduDetailsPageState extends State<EduDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('私教申请详情'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle('用户信息'),
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    color: Colors.red,
                  ),
                  Column(
                    children: [
                      Text('昵称'),
                      Text('vip')
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20,),

              _buildTitle('入驻信息'),


              Text('私教资质'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(4, (index) =>  Container(
                    width: 150,
                    height: 150,
                    color: Colors.red,
                    margin: EdgeInsets.only(right: 10),
                  )),
                ),
              ),

              Text('身份证照片'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(3, (index) =>  Container(
                    width: 150,
                    height: 150,
                    color: Colors.red,
                    margin: EdgeInsets.only(right: 10),
                  )),
                ),
              ),
              Text('经验: 跳舞，两年'),
              Text('真实姓名：xxx'),
              Text('手机号：xxx'),
              Text('身份证号：xxx'),
              Text('行业类型：xxx'),
              Text('所在地：xxx'),
              Text('社会信用代码：xxx'),
              Text('机构证明图片 url：xxx'),

              SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: Colors.green
                      ),
                      child: Text('通过'),
                    ),
                  )),
                  const SizedBox(width: 20,),
                  Expanded(child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: Colors.black
                      ),
                      child: Text('不通过'),
                    ),
                  )),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }


  _buildTitle(String title){
    return Text(title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),);
  }
}
