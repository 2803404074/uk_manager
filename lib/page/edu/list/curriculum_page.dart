
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/page/edu/details/curriculum_details_page.dart';
import 'package:uk_manager/router/main_routers.dart';

import '../../../widget/u_image.dart';
import 'curriculum_model.dart';

class CurriculumPage extends StatefulWidget {
  const CurriculumPage({Key? key}) : super(key: key);

  @override
  State<CurriculumPage> createState() => _CurriculumPageState();
}

class _CurriculumPageState extends State<CurriculumPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => CurriculumModel(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),


          Selector<CurriculumModel,int>(builder: (context,value,child){
            var model = context.read<CurriculumModel>();
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    model.oneList.length,
                        (index) => InkWell(
                      onTap: (){
                        model.changeIndex(0, index);
                      },
                      child: Container(
                        child: Text(model.oneList[index]),
                        margin: const EdgeInsets.only(left: 10),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: value == index?Colors.orange:Colors.grey),
                      ),
                    )),
              ),
            );
          }, selector: (context,model)=>model.oneCurrentIndex),
          SizedBox(
            height: 10,
          ),
          Selector<CurriculumModel,int>(builder: (context,value,child){
            var model = context.read<CurriculumModel>();
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    model.towList.length,
                        (index) => InkWell(
                      onTap: (){
                        model.changeIndex(1, index);
                      },
                      child: Container(
                        child: Text(model.towList[index]),
                        margin: const EdgeInsets.only(left: 10),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: value == index?Colors.orange:Colors.grey),
                      ),
                    )),
              ),
            );
          }, selector: (context,model)=>model.towCurrentIndex),
          SizedBox(
            height: 10,
          ),

          Selector<CurriculumModel,int>(builder: (context,value,child){
            var model = context.read<CurriculumModel>();
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    model.threeList.length,
                        (index) => InkWell(
                      onTap: (){
                        model.changeIndex(2, index);
                      },
                      child: Container(
                        child: Text(model.threeList[index]),
                        margin: const EdgeInsets.only(left: 10),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: value == index?Colors.orange:Colors.grey),
                      ),
                    )),
              ),
            );
          }, selector: (context,model)=>model.threeCurrentIndex),
          SizedBox(
            height: 10,
          ),

          Selector<CurriculumModel,int>(builder: (context,value,child){
            var model = context.read<CurriculumModel>();
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    model.fourList.length,
                        (index) => InkWell(
                          onTap: (){
                            model.changeIndex(3, index);
                          },
                      child: Container(
                        child: Text('${model.fourList[index]['name']}'),
                        margin: const EdgeInsets.only(left: 10),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: value == index?Colors.orange:Colors.grey),
                      ),
                    )),
              ),
            );
          }, selector: (context,model)=>model.fourCurrentIndex),
          SizedBox(
            height: 10,
          ),



          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 200,
                child: TextField(),
              ),
              TextButton(onPressed: () {}, child: Text('搜索'))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: Consumer<CurriculumModel>(builder: (context,model,child){


                return ListView.separated(
                    itemCount: model.curriculumList.length,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) {
                      var data = model.curriculumList[index];
                      return Row(
                        children: [
                          UImage(
                          '${data.cover}',
                            mWidth: 160,
                            mHeight: 100,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Container(
                                height: 100,
                                child: Column(
                                  children: [
                                    Text(
                                      '${data.title}',
                                      style: const TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    Text('发布时间:${data.postTime}'),
                                    Expanded(child: SizedBox()),
                                    Text('作者:${data.nickName}       状态：${data.status==0?'审核通过':data.status == 2?'未通过':'审核通过'}'),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, MainRouter.curriculumDetailsPage,
                                    arguments: {'cId': 12});
                              },
                              child: Text('审核')),
                          TextButton(onPressed: () {}, child: Text('下架')),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 20,
                        thickness: 1,
                        color: Colors.black26,
                      );
                    },
                    );
              },)),

          Selector<CurriculumModel,int>(builder: (context,value,child){
            var model = context.read<CurriculumModel>();
            return Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width*0.5,
                padding: EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[200]
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(onPressed: (){

                    }, child: const Text('上一页')),
                    Expanded(child: Center(child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(10, (index) => InkWell(
                          onTap: (){
                            model.loadList(false,currentIndex: index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: model.page == index?Colors.red:null,
                            ),
                            child: Text('${index+1}'),
                          ),
                        )),
                      ),
                    ),)),
                    TextButton(onPressed: (){

                    }, child: const Text('下一页')),
                  ],
                ),
              ),
            );
          }, selector: (context,model)=>model.page),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
