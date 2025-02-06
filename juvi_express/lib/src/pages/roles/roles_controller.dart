import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juvi_express/src/models/rol.dart';
import 'package:juvi_express/src/models/user.dart';

class RolesController extends GetxController {

  User user = User.fromJson(GetStorage().read('user') ?? {});


  void goToPageRol(Rol rol){
    Get.offNamedUntil(rol.route ?? '', (route) => false);

  }

  /*
  String _getRoleRoute(Rol rol) {
    switch (rol.name) {
      case 'Cliente':
        return '/client/products/list';
      case 'Repartidor':
        return '/delivery/orders/list';
      case 'Administrador':
        return '/admin/orders/list';
      default:
        return '/';
    }
  }


  void goToPageRol(Rol rol) {
  String route = _getRoleRoute(rol);
  
  // Guardar el rol seleccionado en GetStorage
  GetStorage().write('selected_role', rol.toJson());

  // Imprimir para depuración
  print('Navegando a: $route');

  // Navegar a la ruta correspondiente
  Get.offNamed(route);
 }*/


  
}