import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/product.dart';
import 'package:juvi_express/src/pages/delivery/orders/detail/delivery_orders_detail_controller.dart';
import 'package:juvi_express/src/utils/relative_time_util.dart';
import 'package:juvi_express/src/widgets/no_data_widget.dart';

class DeliveryOrdersDetailPage extends StatelessWidget {
  DeliveryOrdersDetailController con = Get.put(DeliveryOrdersDetailController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      bottomNavigationBar: Container(
        color: Color.fromRGBO(245, 245, 245, 1),
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          children: [
            _dataDate(),
            _dataClient(),
            _dataAddress(),
            _totalToPay(context),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Orden #${con.order.id}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: con.order.products!.isNotEmpty
      ? ListView(
        children: con.order.products!.map((Product product) {
          return _cardProduct(product);
        }).toList(),
      )
      : Center(
          child: NoDataWidget(text: 'No hay ningun producto agregado aun')
      ),
    ));
  }

  Widget _dataClient() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text(
          'Cliente y Teléfono',
          style: TextStyle(color: Colors.teal),
        ),
        subtitle: Text('${con.order.client?.name ?? ''} ${con.order.client?.lastname ?? ''} - ${con.order.client?.phone ?? ''}'),
        //trailing: Icon(Icons.person, color: Colors.teal),
        trailing: Icon(Icons.person),
      ),
    );
  }

  Widget _dataAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text(
          'Dirección de entrega',
          style: TextStyle(color: Colors.teal),
        ),
        subtitle: Text(con.order.address?.address ?? ''),
        //trailing: Icon(Icons.location_on, color: Colors.teal),
        trailing: Icon(Icons.location_on),
        
      ),
    );
  }

  Widget _dataDate() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text(
          'Fecha del pedido',
          style: TextStyle(color: Colors.teal),
        ),
        subtitle: Text('${RelativeTimeUtil.getRelativeTime(con.order.timestamp ?? 0)}'),
        //trailing: Icon(Icons.timer, color: Colors.teal),
        trailing: Icon(Icons.timer),
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              _imageProduct(product),
              SizedBox(width: 15),
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
                    SizedBox(height: 5),
                    Text(
                      'Cantidad: ${product.quantity}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageProduct(Product product) {
    return Container(
      height: 50,
      width: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
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

  Widget _totalToPay(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[300]),
        Container(
          margin: EdgeInsets.only(left: con.order.status == 'PAGADO' ? 30 : 37, top: 15),
          child: Row(
            mainAxisAlignment: con.order.status == 'PAGADO'
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text(
                'TOTAL: \$${con.total.value}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.teal // Cambiar color a teal
                ),
              ),
              con.order.status == 'DESPACHADO'
              ? _buttonUpdateOrder()
              : con.order.status == 'EN CAMINO'
                ? _buttonGoToOrderMap()
                : Container()
            ],
          ),
        )
      ],
    );
  }

  Widget _buttonUpdateOrder() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32),
      child: ElevatedButton(
          onPressed: () => con.updateOrder(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(15),
              backgroundColor: Colors.amber
          ),
          child: Text(
            'INICIAR ENTREGA',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }

  Widget _buttonGoToOrderMap() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 27),
      child: ElevatedButton(
          onPressed: () => con.goToOrderMap(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(15),
              backgroundColor: Colors.amber
          ),
          child: Text(
            'VOLVER AL MAPA',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }
}
