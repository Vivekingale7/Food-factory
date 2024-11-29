import 'package:c2w_food_factory/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'order_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<StatefulWidget> createState() => _AdminState();
}

// Drop down list items
const List<String> dropDownList = [
  "Chinese",
  "SouthIndian",
  "Indian",
  "Fast Food"
];

class _AdminState extends State<AdminPage> {
  Future<void> initializeAdminadminItemList() async {
    adminItemList = await getItemList();
  }

  void insertFood(FoodItemModel obj) async {
    await insertFoodItem(obj);
    adminItemList = await getItemList();
    setState(() {});
  }

  void deleteItemFromDB(FoodItemModel obj) async {
    await deleteItem(obj);
    setState(() {});
  }

  void editItem(FoodItemModel obj) async {
    setState(() {});
    await updateItem(obj);
    setState(() {});
  }

  String dropDownValue = dropDownList.first;
  //Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void takeInput(bool isEdit, [int? index]) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Color.fromARGB(219, 2, 106, 135),
            ),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (!isEdit)
                                ? const Text(
                                    "Enter Food Item",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Color.fromARGB(255, 1, 18, 21),
                                        fontWeight: FontWeight.w600),
                                  )
                                : const Text(
                                    "Edit Food Item",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Color.fromARGB(255, 1, 18, 21),
                                        fontWeight: FontWeight.w600),
                                  ),
                          ],
                        ),
                        const Text(
                          "Name",
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 18, 21),
                              fontSize: 25),
                        ),
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Name Of Food";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 158, 186, 180),
                              suffixIcon: const Icon(Icons.set_meal),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  gapPadding: 5),
                              hintText: "Enter Food Name",
                              hintStyle: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w400)),
                        ),
                        const Text(
                          "Description",
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 18, 21),
                              fontSize: 25),
                        ),
                        TextFormField(
                          controller: descriptionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Food Description";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 158, 186, 180),
                              suffixIcon: const Icon(Icons.description),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  gapPadding: 5),
                              hintText: "Enter Description",
                              hintStyle: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w400)),
                        ),
                        const Text("Price",
                            style: TextStyle(
                                color: Color.fromARGB(255, 1, 18, 21),
                                fontSize: 25)),
                        TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Price";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 158, 186, 180),
                              suffixIcon:
                                  const Icon(Icons.price_change_rounded),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  gapPadding: 5),
                              hintText: "Enter Price",
                              hintStyle: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w400)),
                        ),
                        Row(
                          children: [
                            const Text("Category: ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 1, 18, 21),
                                    fontSize: 25)),
                            const Spacer(),
                            DropdownButton(
                              elevation: 10,
                              value: dropDownValue,
                              onChanged: (value) {
                                setState(() {
                                  dropDownValue = value.toString();
                                });
                              },
                              items: dropDownList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 1, 18, 21),
                                          fontSize: 25),
                                    ));
                              }).toList(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 18, 184, 187))),
                                onPressed: () {
                                  if (isEdit) {
                                    editItem(FoodItemModel(
                                        foodName: nameController.text,
                                        foodDescription:
                                            descriptionController.text,
                                        price:
                                            double.parse(priceController.text),
                                        category: dropDownValue,
                                        id: adminItemList[index!].id));
                                  } else {
                                    insertFood(FoodItemModel(
                                        foodName: nameController.text,
                                        foodDescription:
                                            descriptionController.text,
                                        price:
                                            double.parse(priceController.text),
                                        category: dropDownValue));
                                  }
                                  Navigator.of(context).pop();
                                  nameController.clear();
                                  descriptionController.clear();
                                  priceController.clear();
                                  dropDownValue = dropDownList.first;
                                },
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(255, 1, 18, 21)),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(226, 0, 22, 28),
      appBar: AppBar(
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        backgroundColor: const Color.fromARGB(219, 2, 106, 135),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 650,
                child: ListView.builder(
                    itemCount: adminItemList.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        closeOnScroll: true,
                        endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: const DrawerMotion(),
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          nameController.text =
                                              adminItemList[index].foodName;
                                          descriptionController.text =
                                              adminItemList[index]
                                                  .foodDescription;
                                          priceController.text =
                                              adminItemList[index]
                                                  .price
                                                  .toString();
                                          dropDownValue =
                                              adminItemList[index].category;
                                          takeInput(true, index);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  219, 2, 106, 135),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Icon(
                                            Icons.edit,
                                            color: Color.fromARGB(
                                                255, 167, 176, 173),
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          deleteItemFromDB(
                                              adminItemList[index]);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  219, 2, 106, 135),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                        key: ValueKey(index),
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                          ),
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 12,
                          ),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(219, 2, 106, 135),
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(255, 2, 34, 46),
                                    width: 5)),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 20,
                                  color: Color.fromRGBO(0, 0, 0, 0.13))
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      padding: const EdgeInsets.all(1),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Color.fromRGBO(217, 217, 217, 1),
                                      ),
                                      child: Image.network(
                                        'https://images.pexels.com/photos/1633525/pexels-photo-1633525.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          adminItemList[index].foodName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 1)),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          adminItemList[index].foodDescription,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 1)),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Rs.${adminItemList[index].price}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 1)),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Category : ${adminItemList[index].category}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 1)),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          takeInput(false);
        },
        backgroundColor: const Color.fromARGB(219, 2, 106, 135),
        child: const Icon(
          Icons.add_to_photos_rounded,
          color: Colors.black,
        ),
      ),
    );
  }
}
