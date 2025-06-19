import 'package:ecomm_352/data/remote/helper/app_exception.dart';
import 'package:ecomm_352/data/remote/repositories/user_repo.dart';
import 'package:ecomm_352/ui/sign_up/bloc/user_event.dart';
import 'package:ecomm_352/ui/sign_up/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepo userRepo;

  UserBloc({required this.userRepo}) : super(UserInitialState()) {
    on<SignUpEvent>((event, emit) async {
      emit(UserLoadingState());

      try {
        var res = await userRepo.registerUser(bodyParams: event.bodyParams);
        print(res);
        if (res["status"]) {
          ///shared prefs
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", res["token"]);
          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMessage: res["message"]));
        }
      } catch (e) {
        emit(UserFailureState(errorMessage: e.toString()));
      }
    });
  }
}
