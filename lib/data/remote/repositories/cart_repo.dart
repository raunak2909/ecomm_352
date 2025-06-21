import 'package:ecomm_352/data/remote/helper/api_helper.dart';
import 'package:ecomm_352/utils/constants/app_urls.dart';

class CartRepo{
  ApiHelper apiHelper;
  CartRepo({required this.apiHelper});

  Future<dynamic> addToCart({required int productId, required int qty}) async{
    var bodyParams = {
      "product_id": productId,
      "quantity": qty
    };
    
    try{
      var res = await apiHelper.postAPI(url: AppUrls.productUrl, params: bodyParams);
      return res;
    } catch(e){
      rethrow;
    }
  }

  /// fetch cart
  Future<dynamic> fetchCart() async{
    try{
      var res = await apiHelper.getAPI(url: AppUrls.viewCartUrl);
      return res;
    }catch(e){
      rethrow;
    }
  }

}