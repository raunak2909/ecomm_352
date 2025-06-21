import 'package:ecomm_352/data/remote/repositories/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/remote/models/cart_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState>{
  CartRepo cartRepo;
  CartBloc({required this.cartRepo}): super(CartInitialState()){

    on<AddToCartEvent>((event, emit) async{

      emit(CartLoadingState());

      try{
        dynamic res = await cartRepo.addToCart(productId: event.productId, qty: event.qty);

        if(res["status"] == "true" || res["status"]){
          emit(CartLoadedState());
        } else {
          emit(CartErrorState(errorMsg: res["message"]));
        }

      } catch(e){
        emit(CartErrorState(errorMsg: e.toString()));
      }


    });


    on<FetchCartEvent>((event, emit) async{

      emit(CartLoadingState());

      try{

        dynamic res = await cartRepo.fetchCart();
        if(res['status']){

          List<CartModel> mCart = [];
          for(Map<String, dynamic> eachCart in res['data']){
            mCart.add(CartModel.fromJson(eachCart));
          }

          emit(CartLoadedState(mCartList: mCart));

        } else {
          emit(CartErrorState(errorMsg: res['message']));
        }

      } catch(e){
        emit(CartErrorState(errorMsg: e.toString()));
      }

    });

  }
}