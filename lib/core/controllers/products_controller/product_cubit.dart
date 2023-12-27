import 'package:ecommercr_app/core/controllers/products_controller/product_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/product_model.dart';
import '../../network/constant.dart';
import '../../network/remote/dio_helper.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitState());
  static ProductCubit get(context) => BlocProvider.of(context);
  LaptopsModel? laptopsModel;
  void getHomeProducts(){
    emit(LoadingFetchProducts());
    DioHelperStore.getData(url:ApiConstants.homeApi).then((value){
      laptopsModel = LaptopsModel.fromJson(value.data);
      print(laptopsModel!.product!.length);
      emit(FetchProducts());
    }).catchError((error){
      print(error.toString());
      emit(ErrorFetchProducts());
    });
  }
}