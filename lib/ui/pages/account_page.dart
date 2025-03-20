import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:monetra/bloc/user/user_bloc.dart';
import 'package:monetra/ui/widgets/profile_icon_widget.dart';
import 'package:monetra/ui/widgets/profile_menu_widget.dart';
import 'package:monetra/ui/widgets/show_logout_dialog_widget.dart.dart';
import 'package:monetra/ui/widgets/terms_and_conditions_dialog_widget.dart';
import 'package:monetra/ui/widgets/text_button_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    userNameController.text =
        (context.read<UserBloc>().state as UserAuthenticated).username ?? "";
    return Scaffold(
        backgroundColor: Color(0xffF4F7FF),
        appBar: AppBar(
          backgroundColor: Color(0xff1778FB),
          title: Text(
            "My Profile",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showLogoutDialog(context);
              },
              icon: Icon(
                MdiIcons.locationExit,
                size: 30,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            Stack(clipBehavior: Clip.none, children: [
              Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                  color: Color(0xff1778FB),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 20,
                child: Stack(clipBehavior: Clip.none, children: [
                  Container(
                    padding: EdgeInsets.only(top: 80, bottom: 30),
                    width: MediaQuery.of(context).size.width * .9,
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state is UserAuthenticated) {
                                return Text(
                                  "Hello, ${(state.username != null) ? state.username : "Anonymous"}!",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff0146A5)),
                                );
                              } else {
                                return Text("you are not logged in",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.red));
                              }
                            },
                          ),
                          Text(
                            "Welcome to Monetra",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ProfileIconWidget(
                                  icon: MdiIcons.laptop,
                                  amount: 12,
                                  title: "Devices"),
                              SizedBox(
                                width: 40,
                              ),
                              ProfileIconWidget(
                                  icon: MdiIcons.email,
                                  amount: 8,
                                  title: "Alerts"),
                            ])
                      ],
                    ),
                  ),
                  Positioned(
                    top: -75,
                    left: (MediaQuery.of(context).size.width * .9) / 2 - 75,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffF4F7FF),
                        image: DecorationImage(
                          image: AssetImage('assets/profile.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ]),
              )
            ]),
            Padding(
              padding: EdgeInsets.only(top: 150, left: 20, right: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "General",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProfileMenuWidget(
                    icon: MdiIcons.pencil,
                    title: "Edit Profile",
                    subtitle: "Edit Your Username",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                title: Center(
                                  child: Text("Edit Username",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                ),
                                content: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Color(0xff0146A5),
                                      ),
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButtonWidget(
                                    color: Color(0xff0146A5),
                                    text: "Save",
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ));
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProfileMenuWidget(
                    icon: MdiIcons.account,
                    title: "Add Account",
                    subtitle: "Add New Account",
                    onPressed: () {
                      GoRouter.of(context).go("/account/create");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProfileMenuWidget(
                    icon: MdiIcons.information,
                    title: "App Information",
                    subtitle: "Show terms and conditions",
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButtonWidget(
                              color: Color(0xff0146A5),
                              text: "Close",
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          title: Center(
                            child: Text("Terms and Conditions",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * .57,
                            width: MediaQuery.of(context).size.width * .9,
                            child: Scrollbar(
                              thumbVisibility: true,
                              thickness: 6,
                              radius: Radius.circular(10),
                              child: SingleChildScrollView(
                                child: const TermsAndConditionsDialogWidget(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProfileMenuWidget(
                    icon: MdiIcons.logout,
                    title: "Logout Account",
                    subtitle: "Logout Your Account",
                    onPressed: () {
                      showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
