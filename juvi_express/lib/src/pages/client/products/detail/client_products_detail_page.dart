import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/product.dart';
import 'package:juvi_express/src/pages/client/products/detail/client_products_detail_controller.dart';

class ClientProductsDetailPage extends StatefulWidget {
  final Product? product;

  ClientProductsDetailPage({@required this.product});

  @override
  _ClientProductsDetailPageState createState() =>
      _ClientProductsDetailPageState();
}

class _ClientProductsDetailPageState extends State<ClientProductsDetailPage> {
  final counter = 0.obs;
  final price = 0.0.obs;

  late ClientProductsDetailController con;

  @override
  void initState() {
    super.initState();
    con = Get.put(ClientProductsDetailController());
    con.checkIfProductsWasAdded(widget.product!, price, counter);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              widget.product?.name ?? 'Detalles del Producto',
              style: TextStyle(color: Colors.white), // Texto blanco
            ),
            backgroundColor: Colors.teal,
            iconTheme: IconThemeData(color: Colors.white), // Flecha blanca
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProductImage(),
                SizedBox(height: 20),
                _buildProductDetails(),
                SizedBox(height: 30),
                Text(
                  '¿Cuántas quieres?', // Texto agregado
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                _buildCounterButtons(),
                SizedBox(height: 50), // Espacio adicional entre el botón de agregar y los botones de cantidad
                _buildAddToBagButton(),
              ],
            ),
          ),
        ));
  }

  Widget _buildProductImage() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: widget.product?.image1 != null
              ? NetworkImage(widget.product!.image1!)
              : AssetImage('assets/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.product?.name ?? '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10),
        Text(
          widget.product?.description ?? '',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildCounterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCounterButton('-', () {
          con.removeItem(widget.product!, price, counter);
        }),
        SizedBox(width: 10),
        _buildCounterDisplay('${counter.value}'),
        SizedBox(width: 10),
        _buildCounterButton('+', () {
          con.addItem(widget.product!, price, counter);
        }),
      ],
    );
  }

  Widget _buildCounterButton(String text, VoidCallback onPressed) {
    return Container(
      width: 50,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal, // Fondo ámbar
          shape: CircleBorder(),
          padding: EdgeInsets.zero, // Aseguramos que el texto esté centrado en el círculo
        ),
      ),
    );
  }

  Widget _buildCounterDisplay(String text) {
    return Container(
      width: 60,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildAddToBagButton() {
    return ElevatedButton(
      onPressed: () => con.addToBag(widget.product!, price, counter),
      child: Text(
        'Agregar \$${price.value}',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        minimumSize: Size(200, 50),
      ),
    );
  }
}
