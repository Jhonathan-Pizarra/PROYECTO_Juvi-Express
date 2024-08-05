import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/category.dart';
import 'package:juvi_express/src/models/product.dart';
import 'package:juvi_express/src/pages/client/products/list/client_prducts_list_controller.dart';
import 'package:juvi_express/src/widgets/no_data_widget.dart';


class ClientProductsListPage extends StatelessWidget {

  ClientPrductsListController con = Get.put(ClientPrductsListController());


  @override
  Widget build(BuildContext context) {

    return Obx(() => DefaultTabController(
      length: con.categories.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
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
              return FutureBuilder(
                future: con.getProducts(category.id ?? '1'), 
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasData) {

                    if (snapshot.data!.length > 0) {

                      return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (_, index){
                        return _cardProduct(context, snapshot.data![index]);
                        },
                      );
                        
                    }else{

                      return NoDataWidget(
                      text: 'No hay productos',
                    );

                    }

                  }else{
                    return NoDataWidget(
                      text: 'No hay productos',
                    );
                  }
                }
              );
            }).toList(),
        )
      ),
    ));
  
  }
  

/*
  Widget _bottonBar(){
    return Obx(()=> CustomAnimatedBottomBar(
      containerHeight: 70, 
      backgroundColor: Colors.amber,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      selectedIndex: con.indexTab.value,
      onItemSelected: (index) => con.changeTab(index),
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.apps), 
          title: Text('Home'),
          activeColor: Colors.white,
          inactiveColor: Colors.black
          ),
        BottomNavyBarItem(
          icon: Icon(Icons.list), 
          title: Text('Pedidos'),
          activeColor: Colors.white,
          inactiveColor: Colors.black
          ),
        BottomNavyBarItem(
          icon: Icon(Icons.person), 
          title: Text('Perfil'),
          activeColor: Colors.white,
          inactiveColor: Colors.black
          )
      ],
    ));
  }
  */
  Widget _cardProduct(BuildContext context, Product product){
    return GestureDetector(
      onTap: () => con.openBottomSheet(context, product),
      child: Container(
        //margin: EdgeInsets.only(top: 5, left: 10, right: 10),
        child: ListTile(
          title: Text(
            product.name ?? '',
            style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
          subtitle:  Column(
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
    );
  }
}