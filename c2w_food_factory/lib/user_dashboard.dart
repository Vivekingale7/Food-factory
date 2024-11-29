import 'package:c2w_food_factory/main.dart';
import 'package:c2w_food_factory/order_page.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(226, 0, 22, 28),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    //     //        onTap:(){},
                    child: Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/foodmain.jpeg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 20,
                    child: Text(
                      'Different Kinds of Food',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Food Category  ______',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              itemList =
                                  await getItemFromCategory("SouthIndian");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OrderPage(
                                      selectedCategory: "SouthIndian")));
                            },
                            child: const FoodCard(
                              image: 'assets/images/South.jpeg',
                              description: 'South Indian',
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              itemList = await getItemFromCategory("Chinese");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OrderPage(
                                        selectedCategory: "Chinese",
                                      )));
                            },
                            child: const FoodCard(
                              image: 'assets/images/Chinise-food.jpg',
                              description: 'Chinese',
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              itemList = await getItemFromCategory("Fast Food");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OrderPage(
                                        selectedCategory: "Fast Food",
                                      )));
                            },
                            child: const FoodCard(
                              image: 'assets/images/fastfood.jpg',
                              description: 'Fast Food',
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              itemList = await getItemFromCategory("Indian");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OrderPage(
                                        selectedCategory: "Indian",
                                      )));
                            },
                            child: const FoodCard(
                              image: 'assets/images/indian.jpg',
                              description: 'Indian',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Best Seller   ______',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 10.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FoodCard(
                            image: 'assets/images/samosa.jpg',
                            description: 'Samosa',
                          ),
                        ),
                        Expanded(
                          child: FoodCard(
                            image: 'assets/images/idli.jpg',
                            description: 'Idali Dosa',
                          ),
                        ),
                        Expanded(
                          child: FoodCard(
                            image: 'assets/images/jumbo.webp',
                            description: 'Jambo Burger',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final String image;
  final String description;

  const FoodCard({
    super.key,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(219, 2, 106, 135),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(description,
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(241, 241, 241, 0.824))),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
