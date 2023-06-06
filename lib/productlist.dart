import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_prefernces/detailspage.dart';

import 'ProductModel.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ProductModel> allProduct = [];
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () async {
      try {
        final responce = await http
            .get(Uri.parse('https://fakestoreapi.com/products'), headers: {
          'Content-Type': "application/json",
        });

        if (responce.statusCode == 200) {
          List allProducts = jsonDecode(responce.body).toList();
          print(allProducts);
          for (var obj in allProducts) {
            ProductModel prodModel = ProductModel(
              Id: obj['id'].toString(),
              Title: obj['title'].toString(),
              Price: obj['price'].toString(),
              Description: obj['description'].toString(),
              Image: obj['image'].toString(),
              Rating: obj['rating'].toString(),
            );
            allProduct.add(prodModel);
          }
          // print(prodModel);

          setState(() {
            allProduct;
          });
        }
      } catch (e) {
        print("Catch Error________________");
        print(e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                  itemCount: allProduct.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, i) {
                    return PhysicalModel(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: InkWell(
                        onTap: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Details(allProduct.elementAt(i))),
                          );
                        }),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white12),
                          child: Column(
                            children: [
                              Image.network(
                                allProduct[i].Image.toString(),
                                height: 100,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                allProduct[i].Title.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$' + allProduct[i].Price.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Container(
                                  //   height: 30,
                                  //   width: 20,
                                  //   alignment: Alignment.center,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(5)),
                                  //     color: Colors.yellowAccent,
                                  //
                                  //   ),
                                  // )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
