import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownButtonWidget extends StatelessWidget {
  final String? selected;
  final List<Map<String, String>> list;
  final Function(String?)? onChanged;
  final String title;
  final String hint;
  const DropdownButtonWidget(
      {super.key,
      this.selected,
      required this.list,
      this.onChanged,
      required this.title,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Color(0xff0146A5)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            dropdownColor: Colors.white,
            value: selected,
            hint: Text(
              hint,
              style: GoogleFonts.poppins(
                  fontSize: 14, color: Colors.grey.shade400),
            ),
            style: TextStyle(color: Colors.black),
            items: list.map((group) {
              return DropdownMenuItem(
                value: group["id"],
                child: Text(group["name"]!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    )),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}
