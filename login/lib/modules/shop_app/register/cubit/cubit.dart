import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/shop_app/register/cubit/states.dart';
import 'package:login/shared/network/end_points.dart';
import 'package:login/shared/network/remote/DioHelper.dart';
import '../../../../models/shop_app_model/login_model.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopInitialState());

  late ShopLoginModel loginModel;
  late bool status;
  late String message;
  int currentIndex = 0;
  bool isPassword = true;
  IconData suffix = Icons.visibility;

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {required name, required email, required password, required phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone
      },
    ).then((value) {
      status = value.data['status'];
      message = value.data['message'];
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  void changeVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
