import 'package:flutter/material.dart';

class SuccessfulPayment extends StatefulWidget {
  const SuccessfulPayment({super.key});

  @override
  State<SuccessfulPayment> createState() => _SuccessfulPaymentState();
}

class _SuccessfulPaymentState extends State<SuccessfulPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(226, 0, 22, 28),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                //"https://cdn.dribbble.com/users/2185205/screenshots/7886140/02-lottie-tick-01-instant-2.gif"
                "https://media1.tenor.com/m/BSY1qTH8g-oAAAAC/check.gif",
              ),
              const Text(
                " Your Order Placed Successfully",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                " Order Successful",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                      minimumSize:
                          MaterialStatePropertyAll(Size(double.infinity, 55))),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text(
                    "EXIT",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
