import 'package:flutter/material.dart';
import 'package:httplib/io/http_model.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:httplib/io/sp_util.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/page/main/welcome_page.dart';
import 'package:uk_manager/router/main_routers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  init();
}

void init() async {
  ///设置网络代理
  HttpProxy.httpProxy.init(HttpModel.instance);

  await SpUtils.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'together',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: MainRouter.welcomePage,
      onGenerateRoute: (RouteSettings settings) {
        final String? name = settings.name;
        final Function? pageContentBuilder = MainRouter.mainRouters()[name];
        if (pageContentBuilder != null) {
          if (settings.arguments != null) {
            final Route route = MaterialPageRoute(
                builder: (context) => pageContentBuilder(context,
                    arguments: settings.arguments));
            return route;
          } else {
            final Route route = MaterialPageRoute(
                builder: (context) => pageContentBuilder(context));
            return route;
          }
        }
        return null;
      },
    );
  }
}
