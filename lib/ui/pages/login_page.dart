import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:monetra/bloc/user/user_bloc.dart';
import 'package:monetra/models/user.dart';
// import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  bool _emailTouch = false;
  bool _passwordTouch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1778FB),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 250,
                width: 250,
                child: Image(
                  image: AssetImage('assets/hero-login.png'),
                ),
              ),
            ]),
            Expanded(
                child: Container(
              padding: EdgeInsets.fromLTRB(40, 50, 40, 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: ListView(children: [
                Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff1778FB),
                          ),
                        ),
                        labelText: "Username",
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff1778FB),
                        ),
                        hintText: "your username",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade500,
                        ),
                        errorText: _emailTouch
                            ? _validateEmail(emailController.text)
                            : null,
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _emailTouch = true;
                          _validateEmail(emailController.text);
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        enabledBorder: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff1778FB),
                          ),
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Color(0xff1778FB),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        hintText: "******",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade500,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        errorText: _passwordTouch
                            ? _validatePassword(passwordController.text)
                            : null,
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _passwordTouch = true;
                          _validatePassword(passwordController.text);
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color(0xff1778FB),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocListener<UserBloc, UserState>(
                      listener: (context, state) {
                        if (state is UserAuthenticated) {
                          context.go('/dashboard');
                        } else if (state is UserError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)));
                        }
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            final user = User(
                                email: emailController.text,
                                password: passwordController.text);
                            context.read<UserBloc>().add(LoginUser(user: user));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff1778FB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.fromLTRB(5, 10, 5, 10)),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            ))
          ],
        ));
  }
}

// FUNGSI VALIDATE EMAIL
String? _validateEmail(String email) {
  if (email.isEmpty) {
    return "Email cannot be empty";
  } else if (email.length > 50) {
    return "Email cannot be more than 50 characters";
  }
  return null;
}

// FUNGSI VALIDATE PASSWORD
String? _validatePassword(String password) {
  if (password.isEmpty) {
    return "password cannot be empty";
  } else if (password.length < 6) {
    return "password must be at least 6 characters";
  } else {
    return null;
  }
}
