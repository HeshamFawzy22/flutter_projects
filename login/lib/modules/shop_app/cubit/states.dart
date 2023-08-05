import 'package:login/models/shop_app_model/change_favorites_model.dart';
import 'package:login/models/shop_app_model/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopLoadingState extends ShopStates {}

class ShopSuccessState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessState(this.loginModel);
}

class ShopErrorState extends ShopStates {
  final String error;

  ShopErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopHomeLoadingState extends ShopStates {}

class ShopHomeSuccessState extends ShopStates {}

class ShopHomeErrorState extends ShopStates {}

class ShopCategoriesLoadingState extends ShopStates {}

class ShopCategoriesSuccessState extends ShopStates {}

class ShopCategoriesErrorState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopChangeFavoritesSuccessState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopChangeFavoritesSuccessState(this.model);
}

class ShopChangeFavoritesErrorState extends ShopStates {}

class ShopFavoritesLoadingState extends ShopStates {}

class ShopFavoritesSuccessState extends ShopStates {}

class ShopFavoritesErrorState extends ShopStates {}

class ShopUserDataLoadingState extends ShopStates {}

class ShopUserDataSuccessState extends ShopStates {}

class ShopUserDataErrorState extends ShopStates {}

class ShopUpdateUserDataLoadingState extends ShopStates {}

class ShopUpdateUserDataSuccessState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopUpdateUserDataSuccessState(this.loginModel);
}

class ShopUpdateUserDataErrorState extends ShopStates {}
