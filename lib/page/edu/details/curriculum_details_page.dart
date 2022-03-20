

import 'package:flutter/material.dart';

class CurriculumDetailsPage extends StatefulWidget {
  final int cId;
  const CurriculumDetailsPage({Key? key,required this.cId}) : super(key: key);

  @override
  State<CurriculumDetailsPage> createState() => _CurriculumDetailsPageState();
}

class _CurriculumDetailsPageState extends State<CurriculumDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('课程详情'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text('课程基本信息',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Row(
              children: [
                Container(
                  height: 150,
                  width: 220,
                  color: Colors.red,
                ),

                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('标题'),
                    Text('简介'),
                    Text('发布时间'),
                    Text('作者昵称：xxxx'),
                    Text('视频数量：课程难度'),
                    Text('所属分类：xxxxx   xxx   xxx   xxx'),
                    Text('标签列表：xxx   xxx   xxx'),
                    Text('位置信息:xxxxxxx'),
                    Text('播放量：xxx      点赞量：xx     评论量：xxx')
                  ],
                ))
              ],
            ),

            SizedBox(height: 20,),
            Text('课程视频:共3集',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

            SizedBox(height: 5,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(5, (index) => Container(
                  width: 160,
                  height: 90,
                  color: Colors.red,
                  margin: EdgeInsets.only(right: 10),
                )),
              ),
            ),

            SizedBox(height: 50,),
            Row(
              children: [
                Expanded(child: InkWell(
                  child: Container(
                    child: Text('下架'),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200]
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),),
                Expanded(child: InkWell(
                  child: Container(
                    child: Text('通过'),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200]
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),),
                Expanded(child: InkWell(
                  child: Container(
                    child: Text('删除'),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200]
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),),
              ],
            )

          ],
        ),
      ),
    );
  }
}
