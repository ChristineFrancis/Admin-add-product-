import 'package:addprod/signUp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<void> loginapi(BuildContext context, String number, String password) async {
  final url = Uri.parse("http://localhost:8000/api/login");

  try {
    final response = await http.post( url,
      body: {

        'number': number,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      print("successssssssss");
      final jsonResponse = json.decode(response.body);
      bool success = jsonResponse['success'];

      if (success) {
        String? token = jsonResponse['data']['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('TOKEN', token!);

        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Text("Success"),
              content: Text(jsonResponse['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () { Navigator.of(context).pop();},
                  child: const Text("Next" , style: TextStyle(color:Color((0xff50C2BC))),),
                ),
              ],
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
      }
    } else {
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

      throw Exception('Failed to load data' );


    }
  } catch (e) {
    print(e.toString());}
}

