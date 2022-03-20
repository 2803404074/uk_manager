import 'package:flutter/material.dart';
import 'package:uk_manager/page/edu/list/curriculum_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text('管理系统'),
            bottom: const TabBar(
              tabs:  [
                Tab(text: '课程管理',),
                Tab(text: '私教管理',),
                Tab(text: '用户管理',),
                Tab(text: '广告管理',),
                Tab(text: '直播管理',),
                Tab(text: '会员管理',),
              ],
            ),
            actions: [
              TextButton.icon(onPressed: (){}, icon: Icon(Icons.print), label: Text('退出登录'))
            ],
          ),
          body: TabBarView(
            children: [
              CurriculumPage(),
              CurriculumPage(),
              CurriculumPage(),
              CurriculumPage(),
              CurriculumPage(),
              CurriculumPage(),
            ],
          ),
        ));
  }
}
