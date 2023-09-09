import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/social_app/social_login/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialInitialState());

  // late SocialLoginModel loginModel;
  // late bool status;
  // late String message;
  bool isPassword = true;
  IconData suffix = Icons.visibility;

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required email, required password}) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SocialLoginSuccessState(value.user?.uid));
    }).catchError((error) {
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  void changeVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(SocialLoginChangePasswordVisibilityState());
  }
}
