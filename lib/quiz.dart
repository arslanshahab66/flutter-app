import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:shared_prefernces/models.dart';

class Apiquiz extends StatefulWidget {
  const Apiquiz({super.key});

  @override
  State<Apiquiz> createState() => _ApiquizState();
}

class _ApiquizState extends State<Apiquiz> {
  List<productsModel> allproducts = [];
  getallproducts() async {
    try {
      final responce = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
        headers: {
          'Content-Type': "application/json",
        },
      );

      print(responce.statusCode);

      if (responce.statusCode == 200) {
        print("Body: ${responce.body}");
        List data = jsonDecode(responce.body).toList();

        for (int i = 0; i < data.length; i++) {
          productsModel proModel = productsModel(
            productname: data[i]['title'].toString(),
            price: data[i]['price'].toString(),
            description: data[i]['description'].toString(),
            image: data[i]['image'].toString(),
          );
          allproducts.add(proModel);
          print(proModel.price);
        }
      }
    } catch (e) {
      print("Catch Error________________");
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    "Popular Item",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    "See All",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: allproducts.length,
                    itemBuilder: (BuildContext ctx, i) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Text(allproducts[i].description.toString()),
                            Text(allproducts[i].price.toString()),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
