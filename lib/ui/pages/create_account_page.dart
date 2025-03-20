import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monetra/bloc/user/user_bloc.dart';
import 'package:monetra/models/user.dart';
import 'package:monetra/ui/widgets/show_dialog_alert.dart';
import 'package:monetra/ui/widgets/text_button_widget.dart';
import 'package:monetra/ui/widgets/text_field_create_account_widget.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _emailTouch = false;
  bool _userNameTouch = false;
  bool _passwordTouch = false;
  bool _confirmPasswordTouch = false;
  bool _obsureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCBC05),
      appBar: AppBar(
        backgroundColor: Color(0xffFCBC05),
        title: Text(
          "Hi, Rizky Ardiansyah",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 40, left: 30, right: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      "Create Your New User Account",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        TextFieldCreateAccountWidget(
                          controller: emailController,
                          hintText: "your email",
                          touch: _emailTouch,
                          validate: _validateEmail,
                          onChanged: (value) {
                            setState(() {
                              _emailTouch = true;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldCreateAccountWidget(
                          controller: userNameController,
                          hintText: "Username",
                          touch: _userNameTouch,
                          validate: _validateUsername,
                          onChanged: (value) {
                            setState(() {
                              _userNameTouch = true;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldCreateAccountWidget(
                          controller: passwordController,
                          obsureText: _obsureText,
                          hintText: "Password",
                          touch: _passwordTouch,
                          validate: _validatePassword,
                          onChanged: (value) {
                            setState(() {
                              _passwordTouch = true;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldCreateAccountWidget(
                          controller: confirmPasswordController,
                          obsureText: _obsureText,
                          hintText: "Confirm Password",
                          touch: _confirmPasswordTouch,
                          validate: _validateConfirmPassword,
                          onChanged: (value) {
                            setState(() {
                              _confirmPasswordTouch = true;
                            });
                          },
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        BlocListener<UserBloc, UserState>(
                          listener: (context, state) {
                            if (state is UserAdded) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  title: Center(
                                    child: Text(
                                      "Success",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  content: Text(
                                      "Your account has been created!, please log in to your account",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade700)),
                                  actions: [
                                    TextButtonWidget(
                                      color: Color(0xff0146A5),
                                      text: "OK",
                                      onPressed: () {
                                        GoRouter.of(context).goNamed("login");
                                      },
                                    ),
                                  ],
                                ),
                              );
                            } else if (state is UserError) {
                              showDialogAlert(context, state.message);
                            }
                          },
                          child: TextButtonWidget(
                            color: Color(0xff0146A5),
                            text: "Create Account",
                            onPressed: () {
                              if (emailController.text.isNotEmpty &&
                                  userNameController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty &&
                                  confirmPasswordController.text.isNotEmpty) {
                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  context.read<UserBloc>().add(
                                        AddUser(
                                          newUser: User(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ),
                                        ),
                                      );
                                } else {
                                  showDialogAlert(
                                      context, "Password doesn't match");
                                }
                              } else {
                                showDialogAlert(
                                    context, "Please fill all the fields");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String? _validateEmail(String email) {
  if (email.isEmpty) {
    return "Email cannot be empty";
  } else if ((!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
      .hasMatch(email))) {
    return "Invalid email";
  } else if (email.length > 30) {
    return "Email cannot be more than 30 characters";
  } else {
    return null;
  }
}

String? _validateUsername(String username) {
  if (username.isEmpty) {
    return "Username cannot be empty";
  } else if (username.length > 20) {
    return "Username cannot be more than 20 characters";
  } else {
    return null;
  }
}

String? _validatePassword(String password) {
  if (password.isEmpty) {
    return "Password cannot be empty";
  } else if (password.length < 8) {
    return "Password must be at least 8 characters";
  } else if (!RegExp(
          r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
      .hasMatch(password)) {
    return "Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character";
  } else {
    return null;
  }
}

String? _validateConfirmPassword(String confirmPassword) {
  if (confirmPassword.isEmpty) {
    return "Password cannot be empty";
  } else {
    return null;
  }
}
