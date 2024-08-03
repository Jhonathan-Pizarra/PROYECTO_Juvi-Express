import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/client/products/list/client_prducts_list_controller.dart';

class ClientProductsListPage extends StatelessWidget {

  ClientPrductsListController con = Get.put(ClientPrductsListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            children: [
              Text('Client Products List'),
              ElevatedButton(
                onPressed: () => con.signOut(),
                child: Text('Cerrar sesión'),
              ),
            ]
                    
          ),
      ),
    );
  }
}