import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/components/no_data.dart';
class ConverterView extends StatefulWidget {
  const ConverterView({super.key});

  @override
  State<ConverterView> createState() => _ConverterViewState();
}

class _ConverterViewState extends State<ConverterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar', style: context.theme.textTheme.headline3),
        centerTitle: true,
      ),
      body: const NoData(text: 'This is Calendar Screen'),
    );
  }
}