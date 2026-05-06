import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
class TextbuttonReusable extends StatelessWidget {
   TextbuttonReusable({super.key,this.isLoading = false, required this.callback,required this.label});
  final bool isLoading ;
  final Function() callback;
  final label;

  @override
  Widget build(BuildContext context) {
      return TextButton(
        onPressed: isLoading
            ? null
            : () {
          callback();
        },
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Text(label),
      );

  }
}
