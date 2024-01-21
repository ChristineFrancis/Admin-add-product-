import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

Future<void> addProdAPI(
    BuildContext context,
    String commercialName,
    String medicalName,
    String type,
    String formattedDate,
    int amount,
    double price,
    String companyName , String accessToken) async {
  final url = Uri.parse('http://localhost:8000/api/addMedicin');
  var client = http.Client();

  try {
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',},
      body: {
        'commercial_name': commercialName,
        'Scientific_name': medicalName,
        'category': type,
        'Expiry_data': formattedDate,
        'quantity': amount.toString(),
        'price': price.toString(),
        'Manufacture_Company': companyName,
      },
    );


    if (response.statusCode == 200) {
    print("successssssssss");
    final jsonResponse = json.decode(response.body);
    bool success = jsonResponse['success'];

    // ignore: use_build_context_synchronously
    if (success) { showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Success"),
          content: Text(jsonResponse['message']),
          /*actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Next" , style: TextStyle(color:Color((0xff50C2BC))),),
            ),
          ],*/
        );
      },
    );

    }
    else {

      List<String> errorMessages = [];
      Map<String, dynamic> data = jsonResponse['data'];
      data.forEach((key, value) {
        if (value is List) {
          errorMessages.addAll(value.map<String>((dynamic item) => item.toString()));
        } else if (value is String) {
          // If 'value' is a string, add it directly to errorMessages
          errorMessages.add(value);
        }
      });



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
      throw Exception('Failed to load data');
    }
  }




    else {
      final jsonResponse = json.decode(response.body);
      List<String> errorMessages = [];
      Map<String, dynamic> data = jsonResponse['data'];
      data.forEach((key, value) {
        if (value is List) {
          errorMessages.addAll(value.map<String>((dynamic item) => item.toString()));
        } else if (value is String) {
          // If 'value' is a string, add it directly to errorMessages
          errorMessages.add(value);
        }
      });



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
      throw Exception('Failed to load data');
    }


  }  catch (e) {
  print(e.toString());}
  finally {
    client.close(); // Close the client to free up resources
  }
}

