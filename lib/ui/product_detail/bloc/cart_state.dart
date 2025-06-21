import 'package:ecomm_352/data/remote/models/cart_model.dart';

abstract class CartState{}

class CartInitialState extends CartState{}
class CartLoadingState extends CartState{}
class CartLoadedState extends CartState{
  List<CartModel>? mCartList;
  CartLoadedState({this.mCartList});
}
/*class CartSuccessState extends CartState{
}*/
class CartErrorState extends CartState{
  String errorMsg;
  CartErrorState({required this.errorMsg});
}