import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/page/adv/list/adv_list_page.dart';
import 'package:uk_manager/page/curriculum/list/curriculum_page.dart';
import 'package:uk_manager/page/curriculum/modular/curriculum_modular_page.dart';
import 'package:uk_manager/page/main/index_model.dart';
import '../curriculum/category/category_page.dart';
import '../edu/list/edu_list_page.dart';



class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>IndexModel(context),
    child: Scaffold(
        body: Consumer<IndexModel>(builder: (context,model,child){
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 200,
                color: Colors.black87,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                    ),
                    Text('管理员...',style: TextStyle(color: Colors.white),),

                    TextButton(onPressed: (){}, child: Text('退出',style: TextStyle(color:Colors.white70),)),

                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: List.generate(model.menuMasterList.length, (index) {
                        var vo = model.menuMasterList[index];
                        return ExpansionTile(
                          iconColor: Colors.white,
                          collapsedIconColor: Colors.white,
                          title: Text(vo.title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          children: List.generate(vo.menuList.length, (subIndex){
                            var subVo = vo.menuList[subIndex];
                            return InkWell(
                              onTap: (){
                                model.changePageIndex(subVo.pageIndex);
                              },
                              child: Container(
                                height: 50,
                                color: subVo.pageIndex == model.currentIndex?Colors.black:Colors.transparent,
                                alignment: Alignment.center,
                                child: Text(subVo.title,style: TextStyle(color: subVo.pageIndex == model.currentIndex?Colors.white:Colors.white70),),
                              ),
                            );
                          }),);
                      }),
                    )
                  ]),
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                  child: PageView(
                    controller: model.controller,
                    children: const [
                      CategoryPage(key: PageStorageKey<String>('CategoryPage'),),
                      CurriculumModularPage(key: PageStorageKey<String>('CurriculumModularPage'),),
                      CurriculumPage(key: PageStorageKey<String>('CurriculumPage'),),
                      EduListPage(key: PageStorageKey<String>('EduListPage'),),

                      //用户管理
                      SizedBox(),

                      AdvListPage(key: PageStorageKey<String>('AdvListPage'),),

                      //会员管理
                      SizedBox(),

                      //订单管理
                      SizedBox(),

                      //社交管理
                      SizedBox(),
                    ],
                  ))
            ],
          );
        },)),
    );
  }
}
