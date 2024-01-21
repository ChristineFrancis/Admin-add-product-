
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:addprod/addProdApi.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'logout.dart';
class AddProduct extends StatefulWidget {
  const AddProduct({super.key});
  static Widget get page => const AddProduct(); // Named constructor

  @override
  State<AddProduct> createState() => _AddProductState();

}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> formAddProdKey = GlobalKey();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // ignore: non_constant_identifier_names
  Future<void> Logout() async {
    SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('TOKEN');
    // ignore: use_build_context_synchronously
    await logout(context, token!);
  }

  // TextEditingController controllertype= TextEditingController();
  String? commercialName;
  String? medicalName;
  String? type;
  String? expirationDate;
  int? amount;
  double? price;
  String? companyName;
  DateTime? selectedDate;
  String? formattedDate;


  NavigationRailLabelType labelType=NavigationRailLabelType.all;
  int? _selectedIndex=0;
  void _showOptions() async {
    String? selectedType = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            "Choose an option :",
            style: TextStyle(
                color: Color((0xff50C2BC)), fontWeight: FontWeight.w500),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                activeColor: const Color((0xff50C2BC)),
                title: const Text("Painkillers"),
                value: "Painkillers",
                groupValue: type,
                onChanged: (val) {
                  setState(() {
                    type = val;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                activeColor: const Color((0xff50C2BC)),
                title: const Text("Antibiotics"),
                value: "Antibiotics",
                groupValue: type,
                onChanged: (val) {
                  setState(() {
                    type = val;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                activeColor: const Color((0xff50C2BC)),
                title: const Text("Antihistamines"),
                value: "Antihistamines",
                groupValue: type,
                onChanged: (val) {
                  setState(() {
                    type = val;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                activeColor: const Color((0xff50C2BC)),
                title: const Text("Cosmetics"),
                value: "Cosmetics",
                groupValue: type,
                onChanged: (val) {
                  setState(() {
                    type = val;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                activeColor: const Color((0xff50C2BC)),
                title: const Text("Internal medications"),
                value: "Internal medications",
                groupValue: type,
                onChanged: (val) {
                  setState(() {
                    type = val;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
    if (selectedType != null) {
      setState(() {
        type = selectedType;
      });
    }
  }
  void _showDatePicker(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: currentDate,
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color((0xff50C2BC)), // Change primary color to red
            // hintColor: Colors.red, // Change accent color to red as well
            colorScheme: const ColorScheme.light(primary: Color((0xff50C2BC))),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          selectedDate = pickedDate;
           formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
          // Use the formattedDate string as needed
          print(formattedDate); // This will print the date without the time part
        });
      }

    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: const Color((0xff50C2BC)),
        centerTitle: true,
        title: const Text(
          "ADD YOUR PRODUCT",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        /*leading: MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),*/
      ),
      body:Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(flex: 1,
            child: NavigationRail(
              selectedLabelTextStyle: const TextStyle(fontSize: 20 , fontWeight: FontWeight.w600 , color:  Colors.white ),
              unselectedLabelTextStyle: const TextStyle(fontSize: 15 , fontWeight: FontWeight.w600 , color:  Colors.white ),
              onDestinationSelected: (val){
                setState(() {
                  _selectedIndex=val;
                  print("val:$val");
                  print("seleted:$_selectedIndex");
                  if(val==0){
                    Get.to(const AddProduct());}
                  if(val==1){
                    //Get.to(AddProduct());
                  }
                  if(val==2){
                    Logout();
                  }
                });
              } ,elevation: 60,leading: const Text("Dashoard:" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w600 , color:  Colors.white )),
              selectedIconTheme:  const IconThemeData(color:  Colors.white , size: 40),
              unselectedIconTheme: const IconThemeData(color:  Colors.white , size: 30),
              backgroundColor: const Color((0xff50C2BC)),
              destinations: const [
                NavigationRailDestination(icon: Icon(FontAwesomeIcons.tablets) , label: Text("Add medicine"), padding: EdgeInsets.all(20)),
                NavigationRailDestination(icon: Icon(FontAwesomeIcons.solidRectangleList) , label: Text("Orders") , padding: EdgeInsets.all(20)),
                // ignore: deprecated_member_use
                NavigationRailDestination(icon: Icon(FontAwesomeIcons.signOut) , label: Text("Logout") , padding: EdgeInsets.all(20)),
              ],
              selectedIndex: _selectedIndex,
              labelType: labelType,),
          ),




          Expanded(flex: 6,
            child: Container(
              // height: 4000,
              // width: 4000,
              padding:
                  const EdgeInsets.only(right: 400, left: 400, bottom: 40, top: 20),

              // decoration: const BoxDecoration(color: Colors.white,),
              child: Form(
                key: formAddProdKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        onSaved: (val) {
                          commercialName = val;
                        },
                        validator: (commercialName) {
                          if (commercialName!.isEmpty) return "can't be empty";
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Commercial name :",
                          labelStyle: TextStyle(color: Color((0xff50C2BC))),
                          // ignore: deprecated_member_use
                          icon: Icon(FontAwesomeIcons.sortAlphaDownAlt),
                          iconColor: Color((0xff50C2BC)),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20) , borderSide: BorderSide(color:Color((0xff50C2BC)) , width: 300  ) ,  ) ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextFormField(
                        // controller: controllertype,
                        onSaved: (val) {
                          medicalName = val;
                        },
                        validator: (medicalName) {
                          if (medicalName!.isEmpty) return "can't be empty";
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Medical name :",
                          labelStyle: TextStyle(color: Color((0xff50C2BC))),
                          // ignore: deprecated_member_use
                          icon: FaIcon(FontAwesomeIcons.heartbeat),
                          iconColor: Color((0xff50C2BC)),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20) , borderSide: BorderSide(color:Color((0xff50C2BC)) , width: 300  ) ,  ) ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextFormField(
                        controller: TextEditingController(text: type ?? ""),
                        readOnly: true,
                        onTap: _showOptions,

                        onSaved: (val) {
                          type = val;
                        },
                        validator: (type) {
                          if (type!.isEmpty) return "can't be empty";
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Choose medicine's type",
                          labelStyle: TextStyle(color: Color((0xff50C2BC))),
                          icon: FaIcon(FontAwesomeIcons.pills),
                          iconColor: Color((0xff50C2BC)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextFormField(
                        controller: TextEditingController(text: selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate!) : ''),
                        readOnly: true,
                        onTap:() { _showDatePicker(context); },
                         onSaved: (val) {
                           if (val != null) {
                               selectedDate = DateTime.parse(val); // Convert the String to DateTime
                                  }},
                        validator: (selectedDate) {
                          if (selectedDate!.isEmpty) return "can't be empty";
                          return null;

                        },
                        //keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          labelText: "Expiration date :",
                          labelStyle: TextStyle(color: Color((0xff50C2BC))),
                          icon: FaIcon(FontAwesomeIcons.calendarXmark),
                          iconColor: Color((0xff50C2BC)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextFormField(
                        onSaved: (val) {
                         amount =int.parse(val!) ;
                        },
                        validator: (amount) {
                          if (amount!.isEmpty) return "can't be empty";
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          labelText: "Amount :",
                          labelStyle: TextStyle(color: Color((0xff50C2BC))),
                          icon: FaIcon(FontAwesomeIcons.chartBar),
                          iconColor: Color((0xff50C2BC)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextFormField(
                       // keyboardType: TextInputType.numberWithOptions(
                         // decimal: true,
                         // signed:false ,
                       // ),

                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            final text = newValue.text;
                            if (text.isEmpty) {
                              return newValue;
                            } else {
                              return double.tryParse(text) == null
                                ? oldValue
                                : newValue;
                            }
                          }),
                        ],
                        /*keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(Float32x4.fromFloat64x2(double as Float64x2 x,double  x) as Pattern)
                        ],*/
                        onSaved: (val) {
                           price  = double.parse(val!)  ;
                        },
                        validator: (price) {
                         if (price!.isEmpty) return "can't be empty";
                         return null;


                          //if (  )return "error";
                        },
                        decoration: const InputDecoration(
                          labelText: "Price :",
                          labelStyle: TextStyle(color: Color((0xff50C2BC))),
                          icon: FaIcon(FontAwesomeIcons.dollarSign),
                          iconColor: Color((0xff50C2BC)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextFormField(
                        onSaved: (val) {
                          companyName = val;
                        },
                        validator: (companyName) {
                          if (companyName!.isEmpty) return "can't be empty";
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Company's name :",
                          labelStyle: TextStyle(color: Color((0xff50C2BC))),
                          icon: FaIcon(FontAwesomeIcons.hospital),
                          iconColor: Color((0xff50C2BC)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async{
                        if (formAddProdKey.currentState!.validate()) {
                          formAddProdKey.currentState!.save();
                           print("doneeeeee");
                           print(commercialName);
                           print(medicalName);
                           print(type);
                           //print(selectedDate);
                           print(formattedDate);
                           print(amount);
                           print(price);
                           print(companyName);
                            //await cartController.sendCartItemsToServer(prefs.getString('TOKEN')!);
                            SharedPreferences prefs = await _prefs;
                            String? token = prefs.getString('TOKEN');
                            // Check if token is not null before using it
                            if (token != null) {
                              await addProdAPI(context,commercialName! ,medicalName!,type! , formattedDate! ,amount!, price! ,companyName! , token);
                            } else {
                              // Handle case where token is null
                              // You might want to show an error message or handle it accordingly
                              print('Token not found');
                            }

                        } else { print("something went wrong");}
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 25, bottom: 10),
                        height: 60,
                        width: 180,
                        decoration: const BoxDecoration(
                          color: Color((0xff50C2BC)),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(color: Colors.grey, offset: Offset(2, 3))
                          ],
                        ),
                        child: const Center(
                            child: Text(
                          "ADD",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        )),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
