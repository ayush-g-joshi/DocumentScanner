import 'dart:convert';
import 'dart:developer';
import 'package:customizable_counter/customizable_counter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:docscanner/favourite_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/modalclass.dart';
import 'model/product_model.dart';

class PracticeofApi extends StatefulWidget {
  const PracticeofApi({Key? key}) : super(key: key);

  @override
  State<PracticeofApi> createState() => _PracticeofApiState();
}

class _PracticeofApiState extends State<PracticeofApi> {
  ModalClass? model;
  ProductData? products;
  bool showLoader = false;
  var changed_price;
  List<Product> favouriteList = [];
  @override
  void initState() {
    getData2();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GET API PRACTICE"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {

                    return FavouriteList(product: favouriteList,);
                  },
                ));
              },
              icon: Icon(Icons.favorite,color: Colors.red,))
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: showLoader,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///practice data from  getData2()
                  products?.products?.isNotEmpty ?? false
                      ? SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.sizeOf(context).height,
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return Divider(
                                  thickness: 4,
                                  color: Colors.black,
                                );
                              },
                              itemCount: products?.products?.length ?? 0,
                              itemBuilder: (context, index) {
                                products!.products![index].discountPrice =
                                    (products!.products![index].price ?? 0) -
                                        (((products!.products![index].price ??
                                                    0) *
                                                (products!.products![index]
                                                        .discountPercentage ??
                                                    0)) /
                                            100);

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              child: Center(
                                                  child: Text(
                                                      "${products!.products![index].id}",
                                                      style: TextStyle(
                                                          color: Colors.white))),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                "Brand-${products!.products![index].brand}-${products!.products![index].category}"),
                                          ],
                                        ),
                                        //    products!.products![index].checkFavourite==false?
                                        //    ElevatedButton(onPressed: () {
                                        //
                                        //    }, child: Text("Add to favourite"))
                                        // :  ElevatedButton(onPressed: () {
                                        //
                                        //    }, child: Text("Added to favourite"))
                                      ],
                                    ),
                                    Divider(),
                                    ListTile(
                                      trailing: products!.products![index]
                                                  .checkFavourite ==
                                              false
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  products!.products![index]
                                                      .checkFavourite = true;
                                                  debugPrint(
                                                      "${products!.products![index].checkFavourite}");

                                                  favouriteList.add(products!.products![index]);

                                                  debugPrint("favouriteList--\n $favouriteList");
                                                });
                                              },
                                              icon: Icon(Icons.favorite_border))
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  products!.products![index]
                                                      .checkFavourite = false;
                                                  debugPrint(
                                                      "${products!.products![index].checkFavourite}");
                                                  favouriteList.remove(products!.products![index]);
                                                  debugPrint("favouriteList--\n $favouriteList");
                                                });
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )),
                                      title: Column(
                                        children: [
                                          Text(
                                              "${products!.products![index].title}"),
                                        ],
                                      ),
                                      subtitle: Text(
                                          "${products!.products![index].description}"),
                                      leading: Column(
                                        children: [
                                          ClipOval(
                                              child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  child: Image.network(
                                                      "${products!.products![index].images![0]}"))),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "Rating-${products!.products![index].rating}"),
                                            Text(
                                                "Original price-${products!.products![index].price}"),
                                            Text(
                                                "Discount %-${products!.products![index].discountPercentage}"),
                                            Text(
                                                "Discount price-${products!.products![index].discountPrice!.toInt()}"),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomizableCounter(
                                          borderColor: Colors.black,
                                          borderWidth: 2,
                                          borderRadius: 10,
                                          backgroundColor: Colors.white,
                                          buttonText: "Add Item",
                                          textColor: Colors.black,
                                          textSize: 12,
                                          count: 0,
                                          step: 1,
                                          minCount: 0,
                                          maxCount: 50,
                                          incrementIcon: const Icon(
                                            Icons.add,
                                            color: Colors.black,
                                          ),
                                          decrementIcon: const Icon(
                                            Icons.remove,
                                            color: Colors.black,
                                          ),
                                          onCountChange: (count) {
                                            setState(() {
                                              //showUpdatedPrice(count, products!.products![index].price!.toDouble());
                                              if (count != 0) {
                                                products?.products?[index]
                                                    .quantity = count.toInt();
                                                debugPrint(
                                                    "${products?.products?[index].quantity}");
                                              }
                                              if (count == 0) {
                                                products?.products?[index]
                                                    .quantity = 1;
                                                debugPrint(
                                                    "${products?.products?[index].quantity}");
                                              }
                                            });
                                          },
                                          onIncrement: (count) {},
                                          onDecrement: (count) {},
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Total Bill-${(products!.products![index].discountPrice!.toInt() ?? 0) * (products!.products![index].quantity ?? 1)}")
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        )
                      : Container()

                  ///practice data from  getData()
                  // model!.results!.length!=null?
                  // SingleChildScrollView(
                  //   child: Container(
                  //     height:MediaQuery.sizeOf(context).height,
                  //     child: ListView.builder(
                  //       itemCount:model!.results!.length,
                  //       itemBuilder: (context, index) {
                  //         return Column(children: [
                  //           Text("MALE-${model!.results![index].gender}"),
                  //           Text("NAME-${model!.results![index].name!.first} ${model!.results![index].name!.title} ${model!.results![index].name!.last}"),
                  //           Text("City--${model!.results![index].location!.city}"),
                  //           Text("coordinates-${model!.results![index].location!.coordinates}"),
                  //           Text("country-${model!.results![index].location!.country}"),
                  //           Text("phone-${model!.results![index].phone}"),
                  //           Image.network("${model!.results![index].picture!.medium}"),
                  //           Divider()
                  //         ],);
                  //       },),
                  //   ),
                  // ):Container(),
                ]),
          ),
        ),
      ),
    );
  }

  getData() async {
    debugPrint("We are calling api to get the data");
    var response =
        await http.get(Uri.parse("https://randomuser.me/api/?results=20"));
    model = modalClassFromJson(response.body);
  }

  getData2() async {
    setState(() {
      showLoader = true;
    });
    var response = await http.get(Uri.parse("https://dummyjson.com/products"));

    // debugPrint(response.body);
    products = productDataFromJson(response.body);
    setState(() {
      showLoader = false;
    });
  }
}
