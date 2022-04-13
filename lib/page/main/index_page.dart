import 'package:flutter/material.dart';
import 'package:uk_manager/page/adv/list/adv_list_page.dart';
import 'package:uk_manager/page/curriculum/curriculum_index.dart';
import 'package:uk_manager/page/curriculum/list/curriculum_page.dart';

import '../edu/list/edu_list_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final controller = PageController();

  List<String> menuList = [
    '课程管理',
    '私教管理',
    '广告管理',
    '用户管理',
    '直播管理',
    '会员管理',
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text('管理系统'),
          leading: null,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                    ),
                    Text('管理员...'),

                    TextButton(onPressed: (){}, child: Text('退出')),

                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: List.generate(menuList.length, (index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                            controller.jumpToPage(index);
                          },
                          child: Container(
                            color:
                            currentIndex == index ? Colors.orange : Colors.white,
                            height: 50,
                            width: 150,
                            alignment: Alignment.center,
                            child: Text(menuList[index]),
                          ),
                        );
                      }),
                    )
                  ]),
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                  child: PageView(
                    controller: controller,
                    children: const [
                      CurriculumIndex(),
                      EduListPage(),
                      AdvListPage(),
                      CurriculumPage(),
                      CurriculumPage(),
                      CurriculumPage(),
                    ],
                  ))
            ],
          ),
        ));
  }
}
