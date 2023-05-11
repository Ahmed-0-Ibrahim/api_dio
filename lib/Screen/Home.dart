import 'package:api_dio/Constants.dart';
import 'package:api_dio/Modules/HomeProduct.dart';
import 'package:api_dio/Network/Local/Cache_helper.dart';
import 'package:api_dio/Network/Remote/Dio_helper.dart';
import 'package:api_dio/Screen/Login.dart';
import 'package:api_dio/Screen/Setting.dart';
import 'package:api_dio/Widgts/ProductHome.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  String? name, phone, email;

  Home({Key? key, this.name, this.phone, this.email}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Product>>? products;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = getProducts();
  }

  Future<List<Product>> getProducts() async {
    print('enter fun');
    List<Product> pro = [];
    await DioHelper.getData(endPoint: HOME, token: Static.TOKEN).then((value) {
      print('enter loop');
      print(value!.data['data']['products']);

      for (var item in value.data['data']['products']) {
        pro.add(Product.fromJson(item));
      }
    });
    return pro;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name : ${widget.name}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Email : ${widget.email}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Phone : ${widget.phone}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Setting'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Setting(name: widget.name,email: widget.email,phone: widget.phone,)));
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () async {
                // Update the state of the app
                // ...
                // Then close the drawer
                print("logot ${Static.TOKEN}");
                await DioHelper.postData(endPoint: LOGOUT, token: Static.TOKEN)
                    .then((value) {
                  CacheHelper.removeData('token');
                  Static.TOKEN = null;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                });
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = snapshot.data!;
            return ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidget(
                      name: products[index].name,
                      oldPrice: products[index].oldPrice.toString(),
                      price: products[index].price.toString(),
                      discount: products[index].discount.toString(),
                      imageUrl: products[index].imageUrl),
                );
              },
              itemCount: products.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
