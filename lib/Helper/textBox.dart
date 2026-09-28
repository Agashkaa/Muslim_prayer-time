import 'package:flutter/material.dart';

class Textbox extends StatefulWidget {
  const Textbox({super.key});

  @override
  State<Textbox> createState() => _TextboxState();
}

class _TextboxState extends State<Textbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // Meýdançanyň daşyndaky ýumşak kölege we reňk dizaýny
        decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(16.0), // Gyralarynyň ýumşaklygy
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1), // Çala görünýän kölege
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4), // Kölegeniň aşaka düşüşi
            ),
          ],
        ),
        child: TextField(
          style: const TextStyle(
            fontSize: 16,
            color: Colors.blueGrey,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: "E-poçtaňyzy ýazyň...",
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),

            // Çep tarapdaky owadan ikonka
            prefixIcon: Icon(Icons.email_outlined, color: Colors.deepPurple.shade400),

            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

            // Adaty duran wagty gyra çyzygy (border) bolmazlygy üçin
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide.none,
            ),

            // Meýdança basylanda (Focused) emele gelýän owadan gyra çyzyk
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(
                color: Colors.deepPurple.shade300, // Basylanda reňki üýtgeýär
                width: 1.5,
              ),
            ),

          ),
        ),
      );
    }
}
