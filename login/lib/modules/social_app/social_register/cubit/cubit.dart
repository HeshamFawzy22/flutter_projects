import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/social_app/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialInitialState());

  // late SocialLoginModel loginModel;
  late bool status;
  late String message;
  int currentIndex = 0;
  bool isPassword = true;
  IconData suffix = Icons.visibility;

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {required name, required email, required password, required phone}) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              print(value.user?.email),
              emit(SocialRegisterSuccessState()),
            })
        .catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void changeVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
