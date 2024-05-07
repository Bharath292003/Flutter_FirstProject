import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late bool _isloader;
  @override
  void initState() {
    _isloader = true;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isloader = false;
      });
    });
    super.initState();
  }

  final String apiUrl =
      'https://uiexercise.theproindia.com/api/Product/AddProduct';
  final productname = TextEditingController();
  final quantity = TextEditingController();

  // bool _checkQauntity(String quantity) {
  //   int quan = int.parse(quantity);
  //   if (quan <= 0 || quan >= 10) {
  //     const snackdemo = SnackBar(
  //       content: Text("No zero or > 10"),
  //       backgroundColor: Colors.red,
  //       elevation: 10,
  //       behavior: SnackBarBehavior.floating,
  //       margin: EdgeInsets.all(5),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  //     return false;
  //   }
  //   return true;
  // }

  bool _checkProductName(String productname) {
    if (productname.isEmpty) {
      const snackdemo = SnackBar(
        content: Text("please enter the product name"),
        backgroundColor: Colors.red,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      return false;
    }
    return true;
  }

  void _postData(String productname, String qauntity) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "ProductName": productname,
        "Quantity": int.parse(qauntity),
        "IsActive": true
      }),
    );

    if (response.statusCode == 200) {
      const snackdemo = SnackBar(
        content: Text("Product added successfully"),
        backgroundColor: Colors.green,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      Navigator.pop(context);
    } else {
      const snackdemo = SnackBar(
        content: Text("Invalid details"),
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
        title: const Text('Add Product'),
        // centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 148, 207, 19),
      ),
      body: _isloader
          ? const Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Color.fromARGB(255, 36, 247, 39)),
                strokeWidth: 8,
              ),
            )
          : Center(
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 148, 207, 19),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextFormField(
                        controller: productname,
                        decoration: InputDecoration(
                          hintText: 'Enter ProductName',
                          filled: true,
                          fillColor: Colors.grey[300],
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: quantity,
                        decoration: InputDecoration(
                          hintText: 'Enter Quantity',
                          filled: true,
                          fillColor: Colors.grey[300],
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            padding: const EdgeInsets.all(16.0),
                            textStyle: const TextStyle(fontSize: 20),
                            backgroundColor:
                                const Color.fromARGB(255, 137, 243, 61)),
                        onPressed: () {
                          if (_checkProductName(productname.text)) {
                            _postData(productname.text, quantity.text);
                          }
                        },
                        child: const Text('Buy Now'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
