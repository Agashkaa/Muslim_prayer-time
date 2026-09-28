
import 'package:flutter/material.dart';

class Prayertile extends StatelessWidget {
  const Prayertile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _prayerTile("Ertir", "04:12 AM", false),
          _prayerTile("Öýle", "12:24 PM", false),
          _prayerTile("Ikindi", "04:45 PM", false),
          _prayerTile("Agşam", "07:02 PM", true),
          _prayerTile("Ýatsy", "08:30 PM", false),
        ],
      ),
    );
  }
}
Widget _prayerTile(String name, String time, bool isNext) {
  const Color kAccent = Color(0xFF0F6E5C);
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: isNext ? kAccent.withOpacity(0.10) : Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isNext ? kAccent.withOpacity(0.4) : Colors.black.withOpacity(0.05),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.mosque_outlined,
              size: 20,
              color: isNext ? kAccent : Colors.black45,
            ),
            const SizedBox(width: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isNext ? FontWeight.bold : FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: isNext ? kAccent : Colors.black87,
          ),
        ),
      ],
    ),
  );
}

