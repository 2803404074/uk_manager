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

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  var swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'together',
      theme: ThemeData(
        primarySwatch: createMaterialColor(Colors.black),
        primaryColor: Colors.white,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white)
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary
        )
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
