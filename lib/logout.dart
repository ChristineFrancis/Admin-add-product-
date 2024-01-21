import 'dart:convert';
import 'dart:js';

import 'package:addprod/addProd.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



Future<void> logout(BuildContext context , String accessToken) async {
  try{


  var url = Uri.parse('http://localhost:8000/api/logout');
  var response = await http.post(url, headers: {
  'Authorization': 'Bearer $accessToken',
  });

  if (response.statusCode == 200) {
    print('User logged out successfully');
     accessToken=" ";
print("token:$accessToken");
    final jsonResponse = json.decode(response.body);
    bool success = jsonResponse['success'];

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Success" , style: TextStyle( color:Color((0xff50C2BC))),),
          content: Text(jsonResponse['message']),
         // Get.to(AddProduct());
          actions: <Widget>[
                TextButton(
                 onPressed: () { Navigator.of(context).pop();
                   Get.to(AddProduct());},
                 child: const Text("Next" , style: TextStyle(color:Color((0xff50C2BC))),),
                ),
              ],
        );
      },
    );




  } else {
    print('Failed to log out user');
    print(accessToken);
    final jsonResponse = json.decode(response.body);
    List<String> errorMessages = [];
    Map<String, dynamic> data = jsonResponse['data'];
    data.forEach((key, value) {
      errorMessages.addAll(value.map<String>((dynamic item) => item.toString()));
    });

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Error"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: errorMessages.map((message) => Text(message)).toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Try again"  , style: TextStyle(color:Color((0xff50C2BC)))),
            ),
          ],
        );
      },
    );

    throw Exception('Failed to load data' );


  }
}
 catch (e) {
print(e.toString());}
}
