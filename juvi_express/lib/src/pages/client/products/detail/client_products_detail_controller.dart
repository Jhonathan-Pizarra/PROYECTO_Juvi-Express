import 'package:get/get.dart';
import 'package:juvi_express/src/models/product.dart';

class ClientProductsDetailController extends GetxController{

  Product? product;

  var counter = 1.obs;
  var price = 0.0.obs;

  ClientProductsDetailController(Product product){

    this.product = product;
    price.value = product.price ?? 0.0;

  }

  void addItem(){
    counter.value = counter.value + 1;
    price.value = product!.price! * counter.value;
  }

  void removeItem(){
    if (counter.value > 1) {
      counter.value = counter.value - 1;
      price.value = product!.price! * counter.value;
    }
   
  }

}