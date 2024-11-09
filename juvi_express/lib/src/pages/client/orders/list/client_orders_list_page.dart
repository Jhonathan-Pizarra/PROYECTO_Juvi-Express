import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/order.dart';
import 'package:juvi_express/src/pages/client/orders/list/client_orders_list_controller.dart';
import 'package:juvi_express/src/utils/relative_time_util.dart';
import 'package:juvi_express/src/widgets/no_data_widget.dart';

class ClientOrdersListPage extends StatelessWidget {
  ClientOrdersListController con = Get.put(ClientOrdersListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
          length: con.status.length,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 2,
                bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.teal,
                  labelColor: Colors.teal,
                  unselectedLabelColor: Colors.grey[600],
                  tabs: List<Widget>.generate(con.status.length, (index) {
                    return Tab(
                      child: Text(
                        con.status[index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }),
                ),
              ),
            ),
            body: TabBarView(
              children: con.status.map((String status) {
                return FutureBuilder(
                  future: con.getOrders(status),
                  builder: (context, AsyncSnapshot<List<Order>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.length > 0) {
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                            return _cardOrder(snapshot.data![index], context);
                          },
                        );
                      } else {
                        return Center(child: NoDataWidget(text: 'No hay pedidos'));
                      }
                    } else {
                      return Center(child: NoDataWidget(text: 'No hay pedidos'));
                    }
                  },
                );
              }).toList(),
            ),
          ),
        ));
  }

  Widget _cardOrder(Order order, BuildContext context) {
    return GestureDetector(
      onTap: () => con.goToOrderDetail(order),
      child: Container(
        height: 150,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => _showExpandedImage(context, order.image ?? 'https://cdn-icons-png.flaticon.com/512/2331/2331876.png'),
                child: Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(order.image ?? 'https://cdn-icons-png.flaticon.com/512/2331/2331876.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Comanda #${order.id}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Pedido: ${RelativeTimeUtil.getRelativeTime(order.timestamp ?? 0)}',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Repartidor: ${order.delivery?.name ?? 'No asignado'} ${order.delivery?.lastname ?? ''}',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Entregar en: ${order.address?.address ?? ''}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExpandedImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.9,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
