// ignore: file_names
import 'package:c2w_food_factory/admin_login.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup.dart';

// ignore: camel_case_types
class startPage extends StatefulWidget {
  const startPage({super.key});

  @override
  State<startPage> createState() => _startPageState();
}

// ignore: camel_case_types
class _startPageState extends State<startPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 237, 234, 225)),
              child: const Icon(
                Icons.account_circle,
                size: 100,
              ),
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Food Factory",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Delious and Special Food ",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const LoginPage()));
              },
              child: const Text(
                "Log in",
                style: TextStyle(color: Colors.white, fontSize: 23),
              )),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SignUpScreen()));
              },
              child: const Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 80,
          ),
          ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AdminLogin()));
              },
              child: const Text(
                "Admin Login",
                style: TextStyle(color: Colors.white, fontSize: 23),
              )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              elevation: 10,
              shadowColor: Colors.white,
              child: Image.network(
                "https://imgs.search.brave.com/J6str_AInbhlturj7lAAKoRX0j3rRn2giLUpNkVqblk/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4u/Z3JhYm9uLmluL2dv/Z3JhYm9uL2ltYWdl/cy93ZWItaW1hZ2Vz/L3VwbG9hZHMvMTYx/ODU3NTUxNzk0Mi9m/b29kLWNvdXBvbnMu/anBn",
                height: 140,
              ),
            ),
          )
        ],
      ),
    );
  }
}
