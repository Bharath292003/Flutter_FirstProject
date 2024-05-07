import 'dart:convert';
import "package:flutter/material.dart";
import 'package:flutter_firstproject/pages/add_product.dart';
import 'package:flutter_firstproject/pages/order_product.dart';
// import 'package:flutter_firstproject/pages/order_product.dart';
import 'package:flutter_firstproject/product_data_model.dart';
import 'package:http/http.dart' as http;
// import '../utils/api2cardscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];
  late bool _isloader;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _isloader = true;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isloader = false;
      });
    });
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(
        'https://uiexercise.theproindia.com/api/Product/GetAllProduct'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        products = jsonData.map((data) => ProductModel.fromJson(data)).toList();
      });
    } else {
      // Handle error if needed
    }
  }

  List<ProductModel> filteredProducts(String query) {
    return products
        .where((product) =>
            product.ProductName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.shopping_cart),
            SizedBox(width: 6.0),
            Text('ShopSmart'),
          ],
        ),
        // centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 148, 207, 19),
        actions: [
          IconButton(
            padding: const EdgeInsets.fromLTRB(0, 3, 30, 10),
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddProduct()),
              ).then((value) => fetchProducts());
            },
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[100],
        child: Column(
          children: [
            const DrawerHeader(
              child: Icon(
                Icons.shop_rounded,
                size: 48,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("H O M E"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.mobile_friendly),
              title: const Text("A D D P R O D U C T S"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddProduct()),
                );
              },
            ),
          ],
        ),
      ),
      body: _isloader
          ? const Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Color.fromARGB(255, 36, 247, 39)),
                strokeWidth: 8,
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      // labelText: 'Search products',
                      hintText: 'Search products here......',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _searchController.text.isNotEmpty
                        ? filteredProducts(_searchController.text).length
                        : products.length,
                    itemBuilder: (context, index) {
                      final List<ProductModel> displayedProducts =
                          _searchController.text.isNotEmpty
                              ? filteredProducts(_searchController.text)
                              : products;
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset('lib/images/watch.jpg',
                                  height: 50, width: 50),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  "${displayedProducts[index].ProductName}\nQuantity: ${displayedProducts[index].Quantity}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderProduct(
                                              product: displayedProducts[index],
                                            )),
                                  ).then((value) => fetchProducts());
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  alignment: Alignment.center,
                                  textStyle: const TextStyle(fontSize: 15),
                                  backgroundColor:
                                      const Color.fromARGB(255, 148, 207, 19),
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Order Product'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
