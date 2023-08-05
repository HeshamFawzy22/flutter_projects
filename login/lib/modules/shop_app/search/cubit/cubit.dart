import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/models/shop_app_model/search_model.dart';
import 'package:login/modules/shop_app/search/cubit/states.dart';
import 'package:login/shared/network/end_points.dart';
import 'package:login/shared/network/remote/DioHelper.dart';
import '../../../../shared/components/constants.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchInitialState());

  late SearchModel searchModel;

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  void getSearchData({required text}) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopSearchErrorState());
    });
  }
}
