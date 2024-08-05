import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/product.dart';
import 'package:juvi_express/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ClientProductsDetailPage extends StatelessWidget {

  Product? product;
  late ClientProductsDetailController con;
  // = Get.put(ClientProductsDetailController());

  ClientProductsDetailPage({required this.product}){

    con = Get.put(ClientProductsDetailController(product!));

  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      bottomNavigationBar: Container(
        child: _buttonsAddToBag(),
        height: 100,  
      ),
      body: Column(
        children: [
          _imageSlideshow(context),
          _textNameProduct(),
          _textDescriptionProduct(),
          _textPriceProduct()
        ]
      ),
    ));
  }

  Widget _textNameProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product?.name ?? '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.black
        ),
      ),
    );
  }

  Widget _textDescriptionProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product?.description ?? '',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _textPriceProduct() {
      return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 15, left: 30, right: 30),
        child: Text(
          '\$${product?.price.toString() ?? ''}',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
      );
  }

  Widget _imageSlideshow(BuildContext context) {
  return ImageSlideshow(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      initialPage: 0,
      indicatorColor: Colors.amber,
      indicatorBackgroundColor: Colors.grey,
      children: [
        FadeInImage(
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 50),
            placeholder: AssetImage('assets/img/no-image.png'),
            image: product!.image1 != null
                ? NetworkImage(product!.image1!)
                : AssetImage('assets/img/no-image.png') as ImageProvider
        ),
        FadeInImage(
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 50),
            placeholder: AssetImage('assets/img/no-image.png'),
            image: product!.image2 != null
                ? NetworkImage(product!.image2!)
                : AssetImage('assets/img/no-image.png') as ImageProvider
        ),
        FadeInImage(
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 50),
            placeholder: AssetImage('assets/img/no-image.png'),
            image: product!.image3 != null
                ? NetworkImage(product!.image3!)
                : AssetImage('assets/img/no-image.png') as ImageProvider
        ),
      ]
  );
}

/*
  Widget _buttonsAddToBag() {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[400]),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            '-'
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
            )
          ),
        )
      ],
    );
  }
*/

  Widget _buttonsAddToBag() {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[400]),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 25),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => con.addItem(),
                child: Text(
                  '-',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    //primary: Colors.white,
                    minimumSize: Size(45, 37),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        )
                    )
                ),
              ),
              ElevatedButton(
                onPressed: () => con.addItem(),
                child: Text(
                  '${con.counter.value}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  //primary: Colors.white,
                  minimumSize: Size(40, 37),
                ),
              ),
              ElevatedButton(
                onPressed: () => con.addItem(),
                child: Text(
                  '+',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    //primary: Colors.white,
                    minimumSize: Size(45, 37),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        )
                    )
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () => con.addItem(),
                child: Text(
                  'Agregar   \$${con.price.value}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    //primary: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                    ),
                ),
              ),
            ],
          ),
        )

      ],
    );
  }



}