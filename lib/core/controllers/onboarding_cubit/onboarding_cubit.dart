import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../screens/modules/login.dart';
import '../../managers/nav.dart';
import '../../network/local/cache_helper.dart';
import '../onboarding_states.dart';
class OnBoardingCubit extends Cubit<OnboardingStates>{
  OnBoardingCubit() : super(OnboardingInitState());
  static OnBoardingCubit get(context) => BlocProvider.of(context);
  bool isPageLast = false;
  int screenIndex = 0;
  void pageLast(index){
    isPageLast = true;
    screenIndex = index;
    print(screenIndex);
    emit(PageLast());
  }
  void pageNotLast(index){
    isPageLast = false;
    screenIndex = index;
    print(screenIndex);
    emit(NotPageLast());
  }
  void submit(context){
    CacheHelper.saveData(key:'Boarding', value:true).then((value)=>
    navigateToNextScreen(context, LoginScreen()));
  }
}