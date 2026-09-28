import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {


  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -35,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _infoBlock(
                icon: Icons.timer_outlined,
                label: "GALAN WAGT",
                value: "Magrib 0:53:30",
              ),
              const VerticalDivider(
                color: Colors.black12,
                thickness: 1,
                indent: 4,
                endIndent: 4,
              ),
              _infoBlock(
                icon: Icons.location_on_outlined,
                label: "ÝERLEŞÝÄN ÝERIŇIZ",
                value: " ",
                loading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoBlock({
    required IconData icon,
    required String label,
    required String value,
    bool loading = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: const Color(0xFF0F6E5C)),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        if (loading)
          const SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        else
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF3A2B1D),
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}