import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:monetra/bloc/host/host_bloc.dart';
import 'package:monetra/bloc/host/host_event.dart';
import 'package:monetra/bloc/host/host_state.dart';
import 'package:monetra/models/create_host.dart';
import 'package:monetra/ui/widgets/dropdown_button_widget.dart';
import 'package:monetra/ui/widgets/show_dialog_alert.dart';
import 'package:monetra/ui/widgets/text_button_widget.dart';
import 'package:monetra/ui/widgets/text_field_create_host_widget.dart';

class CreateHostPage extends StatefulWidget {
  const CreateHostPage({super.key});

  @override
  State<CreateHostPage> createState() => _CreateHostPageState();
}

class _CreateHostPageState extends State<CreateHostPage> {
  TextEditingController hostNameController = TextEditingController();
  TextEditingController ipAddressController = TextEditingController();
  TextEditingController portController = TextEditingController();

  String _selectedRadioOption = 'IP';
  String? _selectedGroupId;
  String? _selectedTemplateId;

  bool _hostNameTouch = false;
  bool _ipAddressTouch = false;
  bool _portTouch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF4F7FF),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black, size: 30),
          backgroundColor: Colors.transparent,
          title: Text("Create Host", style: GoogleFonts.poppins(fontSize: 16)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 30, 0),
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      color: Color(0xff1778FB),
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff0146A5),
                            Color(0xff1778FB),
                          ])),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Text("Add a new host to your Monetra Dashboard.  ",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldCreateHostWidget(
                  label: "Host Name",
                  controller: hostNameController,
                  hintText: "Enter Host Name",
                  isTouch: _hostNameTouch,
                  validate: validateHostName,
                  onChanged: (value) {
                    setState(() {
                      _hostNameTouch = true;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldCreateHostWidget(
                  label: "IP Address",
                  keyboardType: TextInputType.number,
                  controller: ipAddressController,
                  hintText: "Enter IP Address",
                  isTouch: _ipAddressTouch,
                  validate: validateIpAddress,
                  onChanged: (value) {
                    setState(() {
                      _ipAddressTouch = true;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(children: [
                  Expanded(
                    child: TextFieldCreateHostWidget(
                      // width: MediaQuery.of(context).size.width * .4,
                      label: "Port",
                      keyboardType: TextInputType.number,
                      controller: portController,
                      hintText: "161",
                      isTouch: _portTouch,
                      validate: validatePort,
                      onChanged: (value) {
                        setState(() {
                          _portTouch = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Connection Type",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.grey.shade700)),
                      Row(
                        children: [
                          Radio(
                              activeColor: Color(0xff0146A5),
                              value: "IP",
                              groupValue: _selectedRadioOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRadioOption = value!;
                                  log(_selectedRadioOption);
                                });
                              }),
                          Text(
                            "IP",
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          Radio(
                              value: "DNS",
                              groupValue: _selectedRadioOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRadioOption = value!;
                                  log(_selectedRadioOption);
                                });
                              }),
                          Text(
                            "DNS",
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    DropdownButtonWidget(
                      list: groups,
                      title: "Group",
                      hint: "Select Group",
                      selected: _selectedGroupId,
                      onChanged: (value) => {
                        setState(() {
                          _selectedGroupId = value;
                        }),
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    DropdownButtonWidget(
                      list: templates,
                      title: "Template",
                      hint: "Select Template",
                      selected: _selectedTemplateId,
                      onChanged: (value) => {
                        setState(() {
                          _selectedTemplateId = value;
                        })
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: BlocListener<HostBloc, HostState>(
                      listener: (context, state) {
                        if (state is HostAdded) {
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
                                        child: Icon(
                                      MdiIcons.checkDecagram,
                                      size: 70,
                                      color: Colors.green,
                                    )),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                              "Host Created Successfully, do you want to create another host?",
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButtonWidget(
                                        color: Color(0xffFCBC05),
                                        text: "Close",
                                        onPressed: () {
                                          Navigator.pop(context);
                                          context.go("/hosts");
                                        },
                                      ),
                                      TextButtonWidget(
                                        color: Color(0xff0146A5),
                                        text: "Create Another",
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ));
                        } else if (state is HostError) {
                          showDialogAlert(context, state.message);
                        }
                      },
                      child: TextButtonWidget(
                        color: Color(0xff1778FB),
                        text: "Create",
                        onPressed: () {
                          context.read<HostBloc>().add(
                                CreateHost(
                                    hostName: hostNameController.text,
                                    ipAddress: ipAddressController.text,
                                    port: portController.text,
                                    groupId: _selectedGroupId ?? "",
                                    templateId: _selectedTemplateId ?? "",
                                    connectionType: _selectedRadioOption),
                              );
                        },
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
