import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/news_app/cubit/states.dart';

import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';
import '../../../shared/network/remote/DioHelper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const ScienceScreen(),
    const SportsScreen(),
  ];

  void changeBottomNavBar(index) {
    currentIndex = index;
    // Get data when click on every bottom nav icon
    // if (index == 1) {
    //   getScience();
    // } else if (index == 2) {
    //   getSports();
    // }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '0640b2940055414eae40f3094cf02659',
    }).then((value) {
      emit(NewsGetBusinessSuccessState());
      //print(value.data['articles'][0]['title']);
      business = (value.data['articles']);
      print(business[0]['title']);
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error));
      print(error.toString());
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '0640b2940055414eae40f3094cf02659',
      }).then((value) {
        emit(NewsGetScienceSuccessState());
        //print(value.data['articles'][0]['title']);
        science = (value.data['articles']);
        print(science[0]['title']);
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error));
        print(error.toString());
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '0640b2940055414eae40f3094cf02659',
      }).then((value) {
        emit(NewsGetSportsSuccessState());
        //print(value.data['articles'][0]['title']);
        sports = (value.data['articles']);
        print(sports[0]['title']);
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error));
        print(error.toString());
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> searchList = [];

  void getSearch({required value}) {
    searchList = [];
    emit(NewsGetSearchLoadingState());
    if (searchList.isEmpty) {
      DioHelper.getData(url: 'v2/everything', query: {
        'q': '$value',
        'apiKey': '0640b2940055414eae40f3094cf02659',
      }).then((value) {
        //print(value.data['articles'][0]['title']);
        searchList = (value.data['articles']);
        print(searchList[0]['title']);
        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchErrorState(error));
      });
    } else {
      emit(NewsGetSearchSuccessState());
    }
  }
}
