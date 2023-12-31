import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/cart_model.dart';
import '../../managers/values.dart';
import '../../network/constant.dart';
import '../../network/remote/dio_helper.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitState());
  static CartCubit get(context) => BlocProvider.of(context);
  void addToCart(productId) {
    DioHelperStore.postData(url: ApiConstants.addCartApi, data: {
      "nationalId": natoinalId,
      "productId": productId,
      "quantity": "1"
    }).then((value) {
      emit(AddToCart());
      getCart();
    }).catchError((error) {
      print(error.toString());
      emit(ErrorAddToCart());
    });
  }

  CartModel? cartModel;
  void getCart() {
    DioHelperStore.getData(url: ApiConstants.getCartApi, data: {
      "nationalId": natoinalId,
    }).then((value) {
      cartModel = CartModel.fromJson(value.data);
      print(cartModel!.products!.length);
      emit(GetCart());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetCart());
    });
  }

  void deleteCart(productId) {
    DioHelperStore.delData(url: ApiConstants.deleteCartApi, data: {
      "nationalId": natoinalId,
      "productId": productId,
    }).then((value) {
      emit(DeleteCart());
      getCart();
    }).catchError((error) {
      print(error.toString());
      emit(ErrorDeleteCart());
    });
  }
  void updateQuantity(quantity,productId){
    DioHelperStore.putData(url:ApiConstants.updateCartApi, data:{
      "nationalId":natoinalId,
      "productId":productId,
      "quantity":quantity
    }).then((value){
      emit(UpdateCart());
      getCart();
    }).catchError((error){
      print(error.toString());
      emit(ErrorUpdateCart());
    });
  }
}