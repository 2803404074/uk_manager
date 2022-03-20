import 'package:flutter/material.dart';
import 'package:uk_manager/page/edu/details/curriculum_details_page.dart';

class CurriculumPage extends StatefulWidget {
  const CurriculumPage({Key? key}) : super(key: key);

  @override
  State<CurriculumPage> createState() => _CurriculumPageState();
}

class _CurriculumPageState extends State<CurriculumPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(height: 20,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
                5,
                (index) => InkWell(
                      child: Container(
                        child: Text('类型'),
                        margin: EdgeInsets.only(left: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey),
                      ),
                    )),
          ),
        ),
        SizedBox(height: 10,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
                5,
                (index) => InkWell(
                      child: Container(
                        child: Text('类型'),
                        margin: EdgeInsets.only(left: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey),
                      ),
                    )),
          ),
        ),
        SizedBox(height: 10,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
                5,
                (index) => InkWell(
                      child: Container(
                        child: Text('类型'),
                        margin: EdgeInsets.only(left: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey),
                      ),
                    )),
          ),
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width: 10,),
            SizedBox(
              width: 200,
              child: TextField(),
            ),
            TextButton(onPressed: () {}, child: Text('搜索'))
          ],
        ),
        SizedBox(height: 10,),
        Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        width: 300,
                        height: 160,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10,),
                      Expanded(child: Container(
                        height:160,
                        child: Column(
                          children: [
                            Text('标题标题',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            Text('发布时间'),
                            Expanded(child: SizedBox()),
                            Text('作者:xxxx       状态：审核通过'),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      )),

                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const CurriculumDetailsPage()));

                      }, child: Text(
                          '审核'
                      )),
                      TextButton(onPressed: (){}, child: Text(
                          '下架'
                      )),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 20,thickness: 1,color: Colors.black26,);
                },
                itemCount: 20))
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
