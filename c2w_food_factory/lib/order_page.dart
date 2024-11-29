import 'package:c2w_food_factory/done.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'main.dart';

class OrderPage extends StatefulWidget {
  final String selectedCategory;

  const OrderPage({required this.selectedCategory, super.key});
  @override
  State createState() => _OrderPageState(selectedCategory);
}

class _OrderPageState extends State {
  String selectedCategory;
  _OrderPageState(this.selectedCategory);
  double total = 0;
  void initializeItemList() async {
    itemList = await getItemFromCategory(selectedCategory);
  }

  @override
  void initState() {
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  // Items Seletected are going to added in the BottomSheet , Code will be here
  void buyInfo() {
    List<FoodItemModel> orderList = [];
    for (int i = 0; i < itemList.length; i++) {
      if (itemList[i].quantity > 0) {
        orderList.add(itemList[i]);
        total += orderList[i].price * orderList[i].quantity;
      }
    }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text(
                    "Review Your Order",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shadowColor: const Color.fromARGB(189, 1, 24, 27),
                        color: const Color.fromARGB(126, 3, 121, 151),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            children: [
                              Text(orderList[index].foodName),
                              const Spacer(),
                              Text(
                                  "${orderList[index].price} * ${orderList[index].quantity} : ${orderList[index].price * orderList[index].quantity} "),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    orderList.remove(orderList[index]);
                                  });
                                },
                                child: Container(
                                    height: 30,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.red.shade400,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    child: const Icon(Icons.remove)),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Text("Total : $total"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            for (int i = 0; i < itemList.length; i++) {
                              itemList[i].quantity = 0;
                            }
                            setState(() {});
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SuccessfulPayment()));
                          },
                          child: const Text("Done"))
                    ],
                  )
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(226, 0, 22, 28),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 40,
                  width: 320,
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)))),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    buyInfo();
                  },
                  child: const SizedBox(
                    child: Icon(
                      size: 30,
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 600,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        //height: 100,

                        decoration: const BoxDecoration(
                            color: Color.fromARGB(226, 0, 22, 28),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border(
                                bottom: BorderSide(color: Colors.white30))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.network(
                                "https://images.pexels.com/photos/1633525/pexels-photo-1633525.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(
                              width: 9,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    itemList[index].foodName,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    itemList[index].foodDescription,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${itemList[index].price}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      const Spacer(),
                                      (itemList[index].quantity == 0)
                                          ? ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  itemList[index].quantity++;
                                                });
                                              },
                                              child: const Text("Add"))
                                          : Row(
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        itemList[index]
                                                            .quantity--;
                                                      });
                                                    },
                                                    child: const Icon(
                                                        Icons.remove)),
                                                Text(
                                                  "${itemList[index].quantity}",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        itemList[index]
                                                            .quantity++;
                                                      });
                                                    },
                                                    child:
                                                        const Icon(Icons.add))
                                              ],
                                            )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FoodItemModel {
  int quantity = 0;
  int? id;
  final String foodName;
  final String foodDescription;
  final double price;
  final String category;
  FoodItemModel(
      {required this.foodName,
      required this.foodDescription,
      required this.price,
      required this.category,
      this.id,
      this.quantity = 0});

  @override
  String toString() {
    return "Name : $foodName | description : $foodDescription | price : $price | category : $category";
  }

// db.execute('''CREATE TABLE food_items(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT,
//         description TEXT,
//         price REAL,
//         category TEXT
//       )''');
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': foodName,
      'description': foodDescription,
      'price': price,
      'category': category
    };
  }
}
