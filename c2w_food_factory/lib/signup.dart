import 'package:c2w_food_factory/main.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _retypePassController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(226, 0, 22, 28),
      body: Container(
        decoration: const BoxDecoration(
            // image: DecorationImage(
            //     image: AssetImage("assets/images/food.jpg"),
            //     fit: BoxFit.fitHeight)),
            ),
        margin: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                _inputFields(context),
                _loginInfo(context),
              ]),
        ),
      ),
    ));
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Create Account",
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text("Enter details to get started",
            style: TextStyle(color: Colors.white)),
      ],
    );
  }

  _inputFields(context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "*all fields are fill mandatory";
              } else {
                return null;
              }
            },
            controller: _userController,
            decoration: InputDecoration(
              hintText: "Username",
              fillColor: Color.fromARGB(255, 248, 242, 248),
              filled: true,
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "*all fields are fill mandatory";
              } else {
                return null;
              }
            },
            controller: _emailController,
            decoration: InputDecoration(
              hintText: "Email id",
              fillColor: Color.fromARGB(232, 252, 250, 250),
              filled: true,
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "*all fields are fill mandatory";
              } else {
                return null;
              }
            },
            controller: _passController,
            decoration: InputDecoration(
              hintText: "Password",
              fillColor: Color.fromARGB(226, 248, 247, 247),
              filled: true,
              prefixIcon: const Icon(Icons.password_outlined),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
            ),
            obscureText: true,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "*all fields are fill mandatory";
              } else {
                return null;
              }
            },
            controller: _retypePassController,
            decoration: InputDecoration(
              hintText: "Retype Password",
              fillColor: Color.fromRGBO(255, 254, 254, 1),
              filled: true,
              prefixIcon: const Icon(Icons.password_outlined),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
            ),
            obscureText: true,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              bool validate = _formKey.currentState!.validate();
              if (validate) {
                String username = _userController.text;
                String pass = _passController.text;
                String retype = _retypePassController.text;

                if (pass == retype) {
                  insertUserInfo(username, pass);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const LoginPage()));
                } else {
                  _userController.clear();
                  _passController.clear();
                  _emailController.clear();
                  _retypePassController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Passwords Didnt Match"),
                  ));
                }
              }
            },
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Color(0xFFE01541)),
            child: const Text(
              "Sign Up",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  _loginInfo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?",
            style: TextStyle(color: Colors.white)),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage()));
            },
            child: const Text("Login"))
      ],
    );
  }
}
