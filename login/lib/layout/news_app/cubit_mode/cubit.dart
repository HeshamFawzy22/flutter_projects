import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/news_app/cubit_mode/states.dart';
import 'package:login/shared/network/local/cache_helper.dart';

class ModeCubit extends Cubit<ModeStates> {
  ModeCubit() : super(AppInitialState());

  static ModeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({fromCache}) {
    if (fromCache != null) {
      isDark = fromCache;
    } else {
      isDark = !isDark;
      CacheHelper.setBool(key: 'isDark', value: isDark)
          .then((value) => emit(AppChangeModeState()));
    }
  }
}
