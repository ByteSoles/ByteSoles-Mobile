import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bytesoles/routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    print("=== Flutter LOGIN DART Info ===");
    print('Login status: ${request.loggedIn}');
    print('Cookies: ${request.cookies}');
    print('Headers: ${request.headers}');
    print("=========================");

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: 26,
              vertical: 40,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildWelcomeSection(),
                const SizedBox(height: 36),
                _buildUsernameField(),
                const SizedBox(height: 34),
                _buildPasswordField(),
                const SizedBox(height: 60),
                _buildLoginButton(request),
                const Spacer(),
                _buildSignUpSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome \nBack!",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        hintText: "Username or Email",
        prefixIcon: const Padding(
          padding: EdgeInsets.all(12),
          child: Icon(Icons.person, color: Colors.black),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        hintText: "Password",
        prefixIcon: const Padding(
          padding: EdgeInsets.all(12),
          child: Icon(Icons.lock, color: Colors.black),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton(CookieRequest request) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          String username = _usernameController.text;
          String password = _passwordController.text;

          final response = await request.login(
            "http://localhost:8000/authentication/login/",
            {
              'username': username,
              'password': password,
            },
          );

          if (!mounted) return;

          if (request.loggedIn) {
            String message = response['message'];
            String uname = response['username'];
            print("=== Flutter build DART Info ===");
            print('Login status: ${request.loggedIn}');
            print('Cookies: ${request.cookies}');
            print('Headers: ${request.headers}');
            print("=========================");

            Navigator.pushReplacementNamed(context, AppRoutes.home);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text("$message Selamat datang, $uname.")),
              );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Login Gagal'),
                content: Text(response['message']),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        "Login",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSignUpSection() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.register),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Create An Account ",
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          const Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
