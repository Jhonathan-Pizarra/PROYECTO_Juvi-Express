import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juvi_express/src/enviroment/enviroment.dart';
import 'package:juvi_express/src/models/category.dart';
import 'package:juvi_express/src/models/response_api.dart';
import 'package:juvi_express/src/models/user.dart';

class CategoriesProvider extends GetConnect {

  
  String url = Enviroment.API_URL + 'api/categories';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Category>> getAll() async {
    Response response = await get(
      '$url/getAll',
      headers: {
        'Content-Type': "application/json",
        'Authorization': userSession.sessionToken ?? ''
      }
    );

    //ResponseApi responseApi = ResponseApi.fromJson(response.body);

    if (response.statusCode == 401) {

      Get.snackbar('Peticion denegada', 'Inicie sesión para continuar');
      return [];
    }

    List<Category> categories = [];
    if (response.body != null && response.body is List) {
      categories = Category.fromJsonList(response.body);
    } else {
      Get.snackbar('Error', 'No se pudo obtener los productos.');
    }
 
    return categories;

  }


  Future<ResponseApi> create (Category category) async {
    Response response = await post(
      '$url/create',
      category.toJson(),
      headers: {
        'Content-Type': "application/json",
        'Authorization': userSession.sessionToken ?? ''
      }
    );

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  
}