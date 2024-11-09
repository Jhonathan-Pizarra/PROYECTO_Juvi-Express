import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/product.dart';
import 'package:juvi_express/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:juvi_express/src/widgets/no_data_widget.dart';

class ClientOrdersCreatePage extends StatelessWidget {

  ClientOrdersCreateController con = Get.put(ClientOrdersCreateController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1), // Fondo de la página
      bottomNavigationBar: Container(
        color: Colors.white, // Fondo del BottomNavigationBar
        height: 100,
        child: _totalToPay(context),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white), // Cambiado a blanco
        title: Text("Mi pedido", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal, // Fondo del AppBar
        elevation: 1, // Sombra del AppBar
      ),
      body: con.selectedProducts.length > 0 
        ? ListView(
            children: con.selectedProducts.map((Product product) {
              return _cardProduct(product);
            }).toList(),
          )
        : Center(child: NoDataWidget(text: 'No hay ningun producto agregado aun')),
    ));
  }

  Widget _totalToPay(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[300]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text(
                "Total: \$${con.total.value}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () => con.goToAddressList(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Confirmar orden",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            _imageProduct(product),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12),
                  _buttonsAddOrRemove(product),
                ],
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _textPrice(product),
                SizedBox(height: 8),
                _iconDelete(product),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageProduct(Product product) {
    return Container(
      height: 70,
      width: 70,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: FadeInImage(
          image: product.image1 != null 
            ? NetworkImage(product.image1!)
            : AssetImage('assets/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }

  Widget _buttonsAddOrRemove(Product product) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => con.removeItem(product),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9),
                bottomLeft: Radius.circular(9),
              ),
            ),
            child: Text(
              "-",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          color: Colors.grey[200],
          child: Text(
            '${product.quantity ?? 0}',
            style: TextStyle(color: Colors.black),
          ),
        ),
        GestureDetector(
          onTap: () => con.addItem(product),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(9),
                bottomRight: Radius.circular(9),
              ),
            ),
            child: Text(
              "+",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _textPrice(Product product) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Text(
        '\$${product.price! * product.quantity!}',
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _iconDelete(Product product) {
    return IconButton(
      onPressed: () => con.deleteItem(product),
      icon: Icon(
        Icons.delete,
        color: Colors.red,
      ),
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
    );
  }
}
