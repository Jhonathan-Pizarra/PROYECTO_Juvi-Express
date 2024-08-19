import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juvi_express/src/models/user.dart';

class AdminHomeController extends GetxController {

  var indexTab = 0.obs;
  //PushNotificationsProvider pushNotificationsProvider = PushNotificationsProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});

  AdminHomeController() {
    saveToken();
  }

  void saveToken() {
    if (user.id != null) {
      //pushNotificationsProvider.saveToken(user.id!);
    }
  }


  void changeTab(int index){
    indexTab.value = index;
  }
  
  void signOut(){
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);

  }
  
}