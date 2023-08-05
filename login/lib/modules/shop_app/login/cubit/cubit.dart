import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/shop_app/login/cubit/states.dart';
import 'package:login/shared/network/end_points.dart';
import 'package:login/shared/network/remote/DioHelper.dart';
import '../../../../models/shop_app_model/login_model.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopInitialState());

  late ShopLoginModel loginModel;
  late bool status;
  late String message;
  bool isPassword = true;
  IconData suffix = Icons.visibility;

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required email, required password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      status = value.data['status'];
      message = value.data['message'];
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  void changeVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShopLoginChangePasswordVisibilityState());
  }
}
