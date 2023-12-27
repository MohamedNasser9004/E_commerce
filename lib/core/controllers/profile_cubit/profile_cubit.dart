import 'package:ecommercr_app/core/controllers/profile_cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_model.dart';
import '../../managers/values.dart';
import '../../network/constant.dart';
import '../../network/remote/dio_helper.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  UserModel? profileModel;
  void getUserData(){
    DioHelperStore.postData(url:ApiConstants.userProfileApi, data:{
      "token": token
    }).then((value){
      profileModel= UserModel.fromJson(value.data);
      print(profileModel!.user!.email);
      emit(GetUserData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetUserData());
    });
  }
}