import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_model.dart';
import '../../network/constant.dart';
import '../../network/remote/dio_helper.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  void userLogin({required email, required password}) {
    emit(LoadingLogin());
    DioHelperStore.postData(url: ApiConstants.loginApi, data: {
      "email": email,
      "gender": 'male',
      "password": password,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      print(userModel!.user!.name!);
      emit(LoginDone(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLogin());
    });
  }
}
