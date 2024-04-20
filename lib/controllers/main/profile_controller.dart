import 'package:dhliz_app/models/main/profile_model.dart';
import 'package:dhliz_app/network/reset_api.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.isRegistered<ProfileController>()
      ? Get.find<ProfileController>()
      : Get.put(ProfileController());

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  ProfileModel? profileModel;
  ProfileDataModel? profileData;
  InfoModel? info;
  AddressModel? address;

  Future<void> getProfile() async {
    final result = await RestApi.getProfile();
    if (result!.isSuccess == true) {
      profileData = result.response.first;
      info = profileData!.info;
      address = info!.address;

    } else {
      print('error');
    }
    update();
  }

}
