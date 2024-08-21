import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/category.dart';
import 'package:juvi_express/src/models/product.dart';
import 'package:juvi_express/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:juvi_express/src/widgets/no_data_widget.dart';

class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
      length: con.categories.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            flexibleSpace: Wrap(
              direction: Axis.horizontal,
              children: [
                _searchBarWithIcons(context),
              ]
            ),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.amber,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
              tabs: List<Widget>.generate(con.categories.length, (index) {
                return Tab(
                  child: Text(con.categories[index].name ?? ''),
                );
              }),
            ),
          ),
        ),
        body: TabBarView(
          children: con.categories.map((Category category) {
            return RefreshIndicator(
              onRefresh: () async {
                // Recargar los productos al hacer pull-to-refresh
                await con.getProducts(category.id ?? '1', con.productName.value);
              },
              child: FutureBuilder(
                future: con.getProducts(category.id ?? '1', con.productName.value),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (_, index) {
                          return _cardProduct(context, snapshot.data![index]);
                        },
                      );
                    } else {
                      return NoDataWidget(
                        text: 'No hay productos',
                      );
                    }
                  } else {
                    return NoDataWidget(
                      text: 'No hay productos',
                    );
                  }
                }
              ),
            );
          }).toList(),
        )
      ),
    ));
  }

  Widget _cardProduct(BuildContext context, Product product){
    return GestureDetector(
      onTap: () => con.openBottomSheet(context, product),
      child: Column(
        children: [
          Container(
            child: ListTile(
              title: Text(
                product.name ?? '',
                style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.description ?? '',
                  maxLines: 2,
                  ),
                  Text(
                    '\$${product.price.toString()}'
                  )
                ],
              ),
              leading: Container(
                height: 70,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: FadeInImage(
                    image: product.image1 != null 
                    ? NetworkImage(product.image1!)
                    : AssetImage('assets/img/no-image.png') as ImageProvider,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                ),
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[300], indent: 37, endIndent: 37,)
        ],
      ),
    );
  }

  Widget _iconShoppingBag() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: con.items.value > 0
        ? Stack(
          children: [
            IconButton(
                onPressed: () => con.goToOrderCreate(),
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  size: 33,
                )
            ),
            Positioned(
                right: 4,
                top: 12,
                child: Container(
                  width: 16,
                  height: 16,
                  alignment: Alignment.center,
                  child: Text(
                    '${con.items.value}',
                    style: TextStyle(
                      fontSize: 12
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                )
            )
          ],
        )
        : IconButton(
            onPressed: () => con.goToOrderCreate(),
            icon: Icon(
              Icons.shopping_bag_outlined,
              size: 30,
            )
        ),
      ),
    );
  }

  Widget _searchBarWithIcons(BuildContext context){
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Icon(Icons.menu, color: Colors.grey), // Icono en la parte izquierda
            SizedBox(width: 10),
            Expanded(
              child: _textFieldSearch(context),
            ),
            SizedBox(width: 10),
            _iconShoppingBag() // Icono de la bolsa de compras en la parte derecha
          ],
        ),
      ),
    );
  }

  Widget _textFieldSearch(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        onChanged: con.onChangeText,
        decoration: InputDecoration(
          hintText: 'Buscar producto',
          suffixIcon: Icon(Icons.search, color: Colors.grey,),
          hintStyle: TextStyle(
            fontSize: 17,
            color: Colors.grey 
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.grey
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.grey
            )
          ),
          contentPadding: EdgeInsets.all(10)
        ),
      ),
    );
  }
}
