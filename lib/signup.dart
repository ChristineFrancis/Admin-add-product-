//import 'package:api/login.dart';
import 'package:addprod/logout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:http/http.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:addprod/signupapi.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addProd.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? fullName;
  String? store;
  String? phoneNumber;
  String? email;
  String? password;
  String? password1;
  String? confirmPassword;
  bool passwordVisible = false;
  bool confirmpasswordVisible = false;
  GlobalKey<FormState> formstateKey = GlobalKey();


  NavigationRailLabelType labelType=NavigationRailLabelType.all;
  int? _selectedIndex;


  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> Logout() async {
    SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('TOKEN');
    await logout(context, token!);
  }

  // SharedPreferences prefs = await _prefs;
  //String? token = prefs.getString('TOKEN');
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(backgroundColor: const Color((0xff50C2BC)),
        centerTitle: true,
        title: const Text("SIGN UP", style: TextStyle(fontSize: 35,
            fontWeight: FontWeight.w500,
            color: Colors.white),),/*leading: MaterialButton(onPressed: (){ Navigator.of(context).pop();},
          child: const Icon(Icons.arrow_back_outlined , color:Colors.white ,),),*/),
      body:Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1,
            child: NavigationRail(
              selectedLabelTextStyle: TextStyle(fontSize: 20 , fontWeight: FontWeight.w600 , color:  Colors.white ),
            unselectedLabelTextStyle: TextStyle(fontSize: 15 , fontWeight: FontWeight.w600 , color:  Colors.white ),
            onDestinationSelected: (val){
              setState(() {
                _selectedIndex=val;
                print("val:$val");
                print("seleted:$_selectedIndex");
                if(val==0){
                Get.to(AddProduct());}
                if(val==1){
                  Get.to(AddProduct());
                 }
                if(val==2){
                  Logout();
                  //Get.to(AddProduct());

                }
              });
            } ,elevation: 60,leading: Text("Dashoard:" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w600 , color:  Colors.white )),
            selectedIconTheme:  IconThemeData(color:  Colors.white , size: 40),
              unselectedIconTheme: IconThemeData(color:  Colors.white , size: 30),
              backgroundColor: Color((0xff50C2BC)),
            destinations: const [
              NavigationRailDestination(icon: Icon(FontAwesomeIcons.tablets) , label: Text("Add medicine"), padding: EdgeInsets.all(20)),
              NavigationRailDestination(icon: Icon(FontAwesomeIcons.solidRectangleList) , label: Text("Orders") , padding: EdgeInsets.all(20)),

              NavigationRailDestination(icon: Icon(FontAwesomeIcons.signOut) , label: Text("Logout") , padding: EdgeInsets.all(20)),
            ],
                selectedIndex: _selectedIndex,
            labelType: labelType,),
          ),




          Expanded(flex: 6,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric( horizontal: 430),
                child: Form(
                  key: formstateKey,
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 380, top: 20),
                        child: Text("Full Name:",
                          style: TextStyle(fontWeight: FontWeight.w600),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextFormField(
                          onSaved: (val) {
                            fullName = val;
                          },
                          validator: (fullName) {
                            if (fullName!.isEmpty) return "can't be empty";
                            if (fullName.length < 5) {
                              return "can't be less than 4 ";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              label: const Text("full name"),
                              labelStyle: (const TextStyle(color: Color(
                                  (0xff50C2BC)))),
                              filled: true,
                              fillColor: Colors.grey[350],
                              border: InputBorder.none
                          ),
                        ),),


                      const Padding(
                        padding: EdgeInsets.only(right: 330, top: 20),
                        child: Text("Repository Name:",
                          style: TextStyle(fontWeight: FontWeight.w600),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextFormField(
                          onSaved: (val) {
                            store = val;
                          },
                          validator: (store) {
                            if (store!.isEmpty) return "can't be empty";
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              label: const Text("repository name"),
                              labelStyle: (const TextStyle(color: Color(
                                  (0xff50C2BC)))),
                              filled: true,
                              fillColor: Colors.grey[350],
                              border: InputBorder.none
                          ),
                        ),),





                      const Padding(
                        padding: EdgeInsets.only(right: 340, top: 20),
                        child: Text("Phone Number:",
                          style: TextStyle(fontWeight: FontWeight.w600),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextFormField(
                            onSaved: (val) {
                              phoneNumber = val;
                            },
                            validator: (phoneNumber) {
                              if (phoneNumber!.isEmpty) return "can't be empty";
                              if (phoneNumber.length < 10) {
                                return "can't be less than 10 numbers";
                              }
                              if (phoneNumber[0] != "0" || phoneNumber[1] != "9") {
                                return "it's not correct";
                              }
                              return null;
                            },
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            // Only numbers can be entered

                            decoration: InputDecoration(

                              label: const Text("phone number"),
                              labelStyle: (const TextStyle(color: Color(
                                  (0xff50C2BC)))),
                              filled: true,
                              fillColor: Colors.grey[350],
                              border: InputBorder.none,
                            )
                        ),
                      ),


                      const Padding(
                        padding: EdgeInsets.only( right: 400),
                        child: Text("Email:",
                          style: TextStyle(fontWeight: FontWeight.w600),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextFormField(
                          onSaved: (val) {
                            email = val;
                          },
                          validator: (email) {
                            if (email!.isEmpty) return "can't be empty";
                            if (!email.contains("@") || !email.contains(".com")) {
                              return "it's not an email address";
                            }
                            return null;
                          },

                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            // hintText : "email",
                              label: const Text("your email adress"),
                              labelStyle: (const TextStyle(color: Color(
                                  (0xff50C2BC)))),
                              filled: true,
                              fillColor: Colors.grey[350],
                              border: InputBorder.none
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 370, top: 15),
                        child: Text("Password:",
                          style: TextStyle(fontWeight: FontWeight.w600),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() {
                              password1 = val;
                            });
                          },
                          onSaved: (val) {
                            password = val;
                          },
                          validator: (password) {
                            if (password!.isEmpty) return "can't be empty";
                            if (password.length < 8) {
                              return "can't be less than 8 numbers";
                            }
                            return null;
                          },
                          obscureText: !passwordVisible,
                          maxLength: 30,
                          keyboardType: TextInputType.visiblePassword,
                          //textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            // hintText : "password",
                            label: const Text("password"),
                            labelStyle: (const TextStyle(color: Color(
                                (0xff50C2BC)))),
                            filled: true,
                            fillColor: Colors.grey[350],
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                                  color: const Color((0xff50C2BC))),
                              onPressed: () {
                                setState(
                                      () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),

                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only( right: 320),
                        child: Text("Confirm Password:",
                          style: TextStyle(fontWeight: FontWeight.w600),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextFormField(
                          onSaved: (val) {
                            confirmPassword = val;
                          },
                          validator: (confirmPassword) {
                            if (confirmPassword!.isEmpty) return "can't be empty";
                            if (confirmPassword.length < 8) {
                              return "can't be less than 8 numbers";
                            }
                            if (confirmPassword != password1) {
                              return "it's wrong , rewrite your password";
                            }
                            return null;
                          },

                          obscureText: !confirmpasswordVisible,
                          maxLength: 30,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            //hintText : "password",
                            label: const Text("your password "),
                            labelStyle: (const TextStyle(color: Color(
                                (0xff50C2BC)))),
                            filled: true,
                            fillColor: Colors.grey[350],
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(confirmpasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                                  color: const Color((0xff50C2BC))),
                              onPressed: () {
                                setState(
                                      () {
                                    confirmpasswordVisible =
                                    !confirmpasswordVisible;
                                  },
                                );
                              },
                            ),

                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(onPressed: () {
                          if (formstateKey.currentState!.validate()) {
                            formstateKey.currentState!.save();
                            print("doneeeeee");
                            print(fullName);
                            print(store);
                            print(phoneNumber);
                            print(email);
                            print(password);
                            print(confirmPassword);
                            signUpAPI(context, fullName!,store! , phoneNumber!, email!, password!);
                            //Get.to(AddProduct());
                          }
                          else {
                            print("password1=$password1");
                            print("confirmPassword=$confirmPassword");
                          }
                        },
                          child:
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 60,
                            width: 180, // Check and adjust this width
                            decoration: const BoxDecoration(
                              color: Color((0xff50C2BC)),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(color: Colors.grey, offset: Offset(2, 3)),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),



                          /* Container(margin: const EdgeInsets.only(top: 10),
                            height: 60,
                            width: 180,
                            decoration: const BoxDecoration(
                              color: Color((0xff50C2BC)),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [BoxShadow(
                                  color: Colors.grey, offset: Offset(2, 3))
                              ],),
                            child: const Center(
                                child: Text("SIGN UP", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),)),),*/
                        ),
                      ),



                      Padding(
                        padding: EdgeInsets.only(top: 15 ),
                        child: Text("Are you already have an account?" , style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 15),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(onPressed: () {/*Get.to(Login());*/  Get.to(AddProduct());},
                          child: Container(margin: const EdgeInsets.only(top: 0),
                            height: 60,
                            width: 180,
                            decoration: const BoxDecoration(
                              color: Color((0xff50C2BC)),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [BoxShadow(
                                  color: Colors.grey, offset: Offset(2, 3))
                              ],),
                            child: const Center(
                                child: Text("LOG IN", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),)),),
                        ),
                      ),

                    ],),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
