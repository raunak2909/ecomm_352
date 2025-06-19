import 'package:ecomm_352/data/remote/helper/api_helper.dart';

import '../../../utils/constants/app_urls.dart';

class ProductRepo{
  ApiHelper apiHelper;
  ProductRepo({required this.apiHelper});

  Future<dynamic> getAllProducts() async{
    try{
      dynamic res = await apiHelper.postAPI(url: AppUrls.productUrl);
      return res;
    } catch (e){
      rethrow;
    }
  }

}