import 'package:customizable_counter/customizable_counter.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'model/product_model.dart';

class FavouriteList extends StatefulWidget {
  final List<Product> product;
   FavouriteList({Key? key,  required this.product}) : super(key: key);

  @override
  State<FavouriteList> createState() => _WishListState();
}

class _WishListState extends State<FavouriteList> {



  @override
  void initState() {

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FavouriteList")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///practice data from  getData2()
                widget.product.isNotEmpty ?? false
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
                      itemCount: widget.product.length ?? 0,
                      itemBuilder: (context, index) {
                        widget.product[index].discountPrice =
                            (widget.product[index].price ?? 0) -
                                (((widget.product[index].price ??
                                    0) *
                                    (widget.product[index]
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
                                              "${widget.product[index].id}",
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
                                        "Brand-${widget.product[index].brand}-${widget.product[index].category}"),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                            ListTile(
onTap: () {
  debugPrint("Count of quantity is-${widget.product[index].quantity}");
},
                              title: Column(
                                children: [
                                  Text(
                                      "${widget.product[index].title}"),
                                ],
                              ),
                              subtitle: Text(
                                  "${widget.product[index].description}"),
                              leading: Column(
                                children: [
                                  ClipOval(
                                      child: Container(
                                          height: 50,
                                          width: 50,
                                          child: Image.network(
                                              "${widget.product[index].images![0]}"))),
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
                                        "Rating-${widget.product[index].rating}"),
                                    Text(
                                        "Original price-${widget.product[index].price}"),
                                    Text(
                                        "Discount %-${widget.product[index].discountPercentage}"),
                                    Text(
                                        "Discount price-${widget.product[index].discountPrice!.toInt()}"),
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
                                  count: widget.product[index].quantity!.toDouble()?? 1.0,
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
                                        widget.product[index]
                                            .quantity = count.toInt();
                                        debugPrint(
                                            "${widget.product[index].quantity}");
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
                                    "Total Bill-${(widget.product[index].discountPrice!.toInt() ?? 0) * (widget.product[index].quantity ?? 1)}")
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                )
                    : Container()

              ]),
        ),
      ),
    );
  }
}