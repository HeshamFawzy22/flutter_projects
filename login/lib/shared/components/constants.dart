import '../../modules/shop_app/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';
// base url : https://newsapi.org/

// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=0640b2940055414eae40f3094cf02659

// https://newsapi.org/v2/everything?q=tesla&apiKey=0640b2940055414eae40f3094cf02659

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value!) {
      navigateAndFinish(context: context, widget: ShopLoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is size of each chunk
  pattern.allMatches(text).forEach((element) {
    print(element.group(0));
  });
}

String? token = '';
