import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/shop_app/cubit/states.dart';
import 'package:login/models/shop_app_model/cartegories_model.dart';
import 'package:login/models/shop_app_model/favorites_model.dart';
import 'package:login/models/shop_app_model/home_model.dart';
import 'package:login/modules/shop_app/categories/categories_screen.dart';
import 'package:login/modules/shop_app/favorites/favorites_screen.dart';
import 'package:login/modules/shop_app/products/products_screen.dart';
import 'package:login/modules/shop_app/settings/settings_screen.dart';
import 'package:login/shared/components/constants.dart';
import 'package:login/shared/network/end_points.dart';
import 'package:login/shared/network/remote/DioHelper.dart';
import '../../../../models/shop_app_model/change_favorites_model.dart';
import '../../../../models/shop_app_model/login_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  ShopLoginModel? loginModel;
  late bool status;
  late String message;
  int currentIndex = 0;
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  Map<int, bool> favorites = {};
  bool isPassword = true;
  IconData suffix = Icons.visibility;
  ChangeFavoritesModel? changeFavoritesModel;
  late FavoritesModel favoritesModel;

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Products',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.apps),
      label: 'Categories',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void changeBottomIndex({required int index}) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  void getHomeData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorite,
        });
      });
      // print(homeModel?.status);
      // print(homeModel?.data.banners[0].image);
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeErrorState());
    });
  }

  void getCategoriesData() {
    emit(ShopCategoriesLoadingState());
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesErrorState());
    });
  }

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // print(value.data);

      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }

      emit(ShopChangeFavoritesSuccessState(changeFavoritesModel!));
    }).catchError((error) {
      emit(ShopChangeFavoritesErrorState());
    });
  }

  void getFavoritesData() {
    emit(ShopFavoritesLoadingState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // print(value.data);
      emit(ShopFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopFavoritesErrorState());
    });
  }

  void getUserData() {
    emit(ShopUserDataLoadingState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      // print(value.data);
      emit(ShopUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopUserDataErrorState());
    });
  }

  void updateUserData({required name, required email, required phone}) {
    emit(ShopUpdateUserDataLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      // print(value.data);
      emit(ShopUpdateUserDataSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateUserDataErrorState());
    });
  }
}
