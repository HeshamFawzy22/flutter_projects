import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/models/social_app/social_user_model.dart';
import 'package:login/modules/social_app/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialInitialState());

  // late SocialLoginModel loginModel;
  // late bool status;
  // late String message;
  int currentIndex = 0;
  bool isPassword = true;
  IconData suffix = Icons.visibility;

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {required name, required email, required password, required phone}) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(name: name, email: email, uId: value.user?.uid, phone: phone);
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate(
      {required name, required email, required uId, required phone}) {
    SocialUserModel userModel = SocialUserModel(
        uId,
        name,
        email,
        phone,
        'https://img.freepik.com/premium-photo/man-with-beard-mustache-smiles-dark-background_826801-944.jpg?w=740',
        'https://img.freepik.com/premium-photo/illustration-people-from-different-cultures-background-generative-ai_803320-2832.jpg?w=996',
        'Write your bio ...');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      print('done');
      emit(SocialUserCreateSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialUserCreateErrorState());
    });
  }

  void changeVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
