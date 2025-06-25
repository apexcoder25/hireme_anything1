import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hire_any_thing/data/models/user_side_model/UserSideDetailsModel.dart';

import '../../models/user_side_model/HomeBannerFirst.dart';

class AuthUserGetXController extends GetxController  {

  UserSideDetailsModel _userSideDetailsModel=UserSideDetailsModel();

  UserSideDetailsModel get userSideDetailsModel => _userSideDetailsModel;

  setUserSideDetailsModel(data){
    _userSideDetailsModel=UserSideDetailsModel.fromJson(data);
    update();
  }



}





