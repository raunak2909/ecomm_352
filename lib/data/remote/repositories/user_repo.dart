import 'package:ecomm_352/data/remote/helper/api_helper.dart';
import 'package:ecomm_352/utils/constants/app_urls.dart';

class UserRepo {
  ApiHelper apiHelper;

  UserRepo({required this.apiHelper});

  Future<dynamic> registerUser({required Map<String, dynamic> bodyParams}) async{
   try{
     dynamic res = await apiHelper.postAPI(
       url: AppUrls.registerUrl,
       isAuth: true,
       params: bodyParams,
     );
     return res;
   } catch(e){
     throw e;
   }
  }

  loginUser() {}
}
