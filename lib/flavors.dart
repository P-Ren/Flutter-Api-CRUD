import 'app/constants/app_config.dart';

enum Flavor {
  dev,
  product,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;
  static String  baseUrl = "";

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        baseUrl = kBaseUrl;
        return 'Salait-dev';
      case Flavor.product:
         baseUrl = kBaseUrl;
        return 'SalaitBlog';
    }
  }

}
