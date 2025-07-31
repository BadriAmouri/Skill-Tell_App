import 'package:flutter/material.dart';

class YourInfo extends StatefulWidget{
  const YourInfo({super.key});

  @override
  State<YourInfo> createState() => _YourInfoState();
}
class _YourInfoState extends State<YourInfo>{
    @override
    Widget build(BuildContext context) {
    return Text("your info page");
  }
}