import 'package:flutter/material.dart';
import 'package:location/location.dart';



class Getlocation extends StatefulWidget {
  const Getlocation({super.key});

  @override
  State<Getlocation> createState() => _GetlocationState();
}

class _GetlocationState extends State<Getlocation> {
  Location location = Location();

  @override
  Widget build(BuildContext context) {

    return const Placeholder();
  }
}

