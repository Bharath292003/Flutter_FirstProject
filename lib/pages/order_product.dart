import "dart:convert";
// import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
// import "package:flutter/widgets.dart";
import "package:flutter_firstproject/product_data_model.dart";
import 'package:http/http.dart' as http;

class OrderProduct extends StatelessWidget {
  final quantity = TextEditingController();
  final ProductModel product;
  final String apiUrl = 'https://uiexercise.theproindia.com/api/Order/AddOrder';
  OrderProduct({super.key, required this.product});
  Future<void> _postproduct(BuildContext context) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "customerId": "f9e86959-d568-44b9-2087-08dc44a8c8ef",
        "productId": product.ProductId,
        "quantity": int.parse(quantity.text)
      }),
    );

    if (response.statusCode == 200) {
      const snackdemo = SnackBar(
        content: Text("successfully added"),
        backgroundColor: Colors.green,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      Navigator.pop(context, true);
    } else {
      const snackdemo = SnackBar(
        content: Text("invalid quantity"),
        backgroundColor: Colors.red,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Products'),
        // centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 148, 207, 19),
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 400,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 148, 207, 19),
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          child: Column(children: [
            const SizedBox(
              height: 4,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(150),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  "${product.ProductName}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Image.asset('lib/images/watch.jpg',
                    height: 100, width: 100)),
            const SizedBox(
              height: 4,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(150),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  "${"Quantity:"}"
                  "${product.Quantity}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: quantity,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(100)),
                    hintText: 'Enter Quantity',
                    filled: true,
                    fillColor: Colors.grey[300],
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 15.0,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 41, 94, 4),
                  padding: const EdgeInsets.all(20.0),
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: const Color.fromARGB(255, 137, 243, 61),
                ),
                onPressed: () {
                  _postproduct(context);
                },
                child: const Text('Buy Now'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
