import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juvi_express/src/models/category.dart';
import 'package:juvi_express/src/models/product.dart';
import 'package:juvi_express/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:juvi_express/src/providers/categories_provider.dart';
import 'package:juvi_express/src/providers/products_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientPrductsListController extends GetxController {

  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();

  //List<Product> selectedProducts = [];
  List<Category> categories = <Category>[].obs;

  ClientPrductsListController(){
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  Future<List<Product>> getProducts(String idCategory) async {

    /*
    if (productName.isEmpty) {
      //return await productsProvider.findByCategory(idCategory);
    }
    else {
      //return await productsProvider.findByNameAndCategory(idCategory, productName);
    }
    */
    return await productsProvider.findByCategory(idCategory);


  }

  void goToOrderCreate(){
    Get.toNamed('/client/orders/create');
  }

  void openBottomSheet(BuildContext context, Product product){

    showMaterialModalBottomSheet(
      context: context, 
      builder: (context) => ClientProductsDetailPage(product: product)
    );
  }



}