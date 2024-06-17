import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:ggmobile/expirement/model/datamodel/qr_screen.dart';
import 'package:ggmobile/model/emman_model.dart';
import 'package:ggmobile/model/placeOrder_model.dart';
import 'package:ggmobile/screens/listofOrders.dart';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/checkout_model.dart';
import 'package:http/http.dart' as http;

import '../model/orderdetails_model.dart';
import '../model/user_model.dart';
import 'package:image_picker/image_picker.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String productId = '';

  File? _image;
  File? _picture;
  String? selectedPaymentMethod;
  bool isGcashButtonClicked = false;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      File? img = File(image.path);
      Uint8List imageBytes = await img.readAsBytesSync();

      print(imageBytes);
      print(img);
      setState(() {
        _image = img;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future _pickPres(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      File? picture = File(image.path);
      setState(() {
        _picture = picture;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  List<CheckOut> checkoutmodel = [];
  late Future<List<CheckOut>> checkoutFuture;

  String? transactionId;
  List<Paymentmodel> place = [];
  List<PlaceOrder> orderItems = [];
  List<EmmanMakulit> emman = [];
  Future<List<Paymentmodel>?> orderDetails(
      String productId, File? image, String? paymentType) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      String? storedBarangayId = prefs.getString('barangayId');
      String? storedUnitSt = prefs.getString('unitSt');
      print(storedUnitSt);
      print(storedBarangayId);

      if (jsonData == null ||
          storedBarangayId == null ||
          storedUnitSt == null) {
        return null;
      }
      print("$jsonData");

      final uri = Uri.parse("https://gorder.website/API/place-order.php");
      var request = http.MultipartRequest('POST', uri);
      request.fields['cust_id'] = '$jsonData';
      request.fields['payment_type'] = paymentType ?? "";
      request.fields['delivery_type'] = 'Deliver';
      request.fields['unit_st'] = storedUnitSt;
      request.fields['bgy_id'] = storedBarangayId;
      request.fields['prescription'] = ''; // Initialize with an empty value

      if (image != null) {
        var imageStream = http.ByteStream(image.openRead());
        var imageLength = await image.length();
        var multipartFile = http.MultipartFile('pof', imageStream, imageLength,
            filename: 'pof.jpg');
        request.files.add(multipartFile);
      }

      var response = await request.send();

      print(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        final jsondata = json.decode(await response.stream.bytesToString());
        if (jsondata is List) {
          List<Paymentmodel> orders = jsondata
              .map((orderJson) => Paymentmodel.fromJson(orderJson))
              .toList();

          setState(() {
            orderItems = orders[0].orderItems;
          });

          return orders;
        }
      }
      return null;
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  bool _prescriptionIstrue = false;
  List<Pepito> pepito = [];
  late Future<List<CheckOut>> checkoutFuture1;

  List<CheckOut> checkout2 = [];

  List<OrderDetails> orderDetailsList = [];
  @override
  void initState() {
    super.initState();

    fetchcheckOut();
    // fetchcheckOut2();
    userFuture = userDetails();
  }

  List<Data> aica = [];
  List<UserModel> userModel = [];
  late Future<List<UserModel>> userFuture;
  Future<List<UserModel>> userDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      if (jsonData != null) {
        Map<String, String> headers = {'Content-Type': 'application/json'};

        final response = await http.get(
          Uri.parse('http://gorder.website/API/user-profile.php?id=$jsonData'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final response1 = json.decode(response.body);
          UserModel user = UserModel.fromJson(response1);

          setState(() {
            aica = [user.data];
          });

          return [user];
        } else {
          setState(() {
            Map<String, dynamic> jsonMap = jsonDecode(response.body);
            String mess = jsonMap['message'];

            print(mess);
            print("failed");
          });
          throw Exception('Failed to load data');
        }
      } else {
        print('userId is null');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }

  String? selectedDeliveryOption;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Checkout',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon pressed
            },
          ),
        ],
      ),
      body: aica.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: aica.length,
                    itemBuilder: (BuildContext context, int index) {
                      // if (index >= pepito.length || index >= pepito.length) {
                      //   return Container(); // Return an empty container if index is out of range
                      // }
                      final e = aica[index];

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.of(context).pushReplacement(MaterialPageRoute(
                            //     builder: ((context) => const ())));
                          },
                          child: Column(
                            children: [
                              Card(
                                child: ListTile(
                                  title: Text("${e.firstName} ${e.lastName}"),
                                  subtitle:
                                      Text("${e.barangay} ${e.municipality}"),
                                  trailing: const Icon(Icons.arrow_right),
                                ),
                              ),
                              // Card(
                              //   child: ListTile(
                              //     leading: Container(
                              //       height: 50,
                              //       width: 40,
                              //       child: Image.network(e.productImg),
                              //     ),
                              //     title: Text(e.productName),
                              //     subtitle: Text(
                              //         'QTY = ${e.qty.toDouble()} QTY Left = ${e.qtyLeft}'),
                              //     trailing: Text("₱${e.amount}"),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pepito.length,
                    itemBuilder: (BuildContext context, int i) {
                      final l = pepito[i];
                      return Card(
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 40,
                            child: Image.network(l.productImg),
                          ),
                          title: Text(l.productName),
                          subtitle: Text("Your order: ${l.qty.toString()}"),
                          trailing: Text("qty left:${l.qtyLeft.toString()}"),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Card(
                    child: ListTile(
                      leading: Text(
                        "Delivery Option",
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: DropdownButton<String>(
                        value: selectedDeliveryOption,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDeliveryOption = newValue;
                          });
                        },
                        items: <String>[
                          'Delivery',
                          'Pick up',
                          // Add more options as needed
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: InkWell(
                      onTap: () {
                        // Handle Subtotal section tap
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Text("Payment Option"),
                ),
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align the buttons to the left
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedPaymentMethod = 'Gcash';
                              isGcashButtonClicked = true;
                            });
                            // Call the orderDetails function with the selected payment method
                            orderDetails(
                                productId, _image, selectedPaymentMethod);
                          },
                          child: Text("Gcash", style: TextStyle(fontSize: 18)),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedPaymentMethod = 'Cash';
                              isGcashButtonClicked =
                                  false; // Reset isGcashButtonClicked when another button is clicked
                            });
                            // Call the orderDetails function with the selected payment method
                            orderDetails(
                                productId, _image, selectedPaymentMethod);
                          },
                          child: Text("Cash", style: TextStyle(fontSize: 18)),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedPaymentMethod = 'Maya';
                              isGcashButtonClicked = true;
                              false; // Reset isGcashButtonClicked when another button is clicked
                            });
                            // Call the orderDetails function with the selected payment method
                            orderDetails(
                                productId, _image, selectedPaymentMethod);
                          },
                          child: Text("Maya", style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isGcashButtonClicked,
                      child: ElevatedButton(
                        onPressed: () {
                          _pickPres(ImageSource.gallery);
                        },
                        child:
                            Text("Upload PoF ", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    Visibility(
                      visible: isGcashButtonClicked,
                      child: Container(
                        height: 50,
                        width: 50,
                        child:
                            _image != null ? Image.file(_image!) : Container(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                      },
                      child: const Text(
                        "upload prescription",
                      )),
                ),
                Visibility(
                  visible: _picture !=
                      null, // Show the prescription image only when an image is uploaded
                  child: Container(
                    height: 200,
                    width: 200,
                    child:
                        _picture != null ? Image.file(_picture!) : Container(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  // Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(builder: ((context) => QrScreen())));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.5, // Adjust the width as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.transparent,
                  ),
                  child: const Center(
                    child: Text(
                      '',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await orderDetails(productId, _image, selectedPaymentMethod);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: ((context) => const AllOrders())));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.3, // Adjust the width as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.lightBlue,
                  ),
                  child: const Center(
                    child: Text(
                      'Place Order', // Replace with your actual subtotal value
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fetchcheckOut() async {
    print('fetchuser');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? jsonData = prefs.getInt('jsonData');

    if (jsonData != null) {
      final url =
          'http://gorder.website/API/check-out-get.php?id=$jsonData&payment_type=Gcash&delivery_type=Deliver';
      print(url);
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      print(json);
      final ord = json['items'] as List<dynamic>;
      final transformed = ord.map((e) {
        return Pepito(
          productId: e["PRODUCT_ID"],
          productName: e["PRODUCT_NAME"],
          productImg: e["PRODUCT_IMG"],
          qtyLeft: e["QTY_LEFT"]?.toInt(),
          qty: e["QTY"]?.toInt(),
          amount: e["AMOUNT"]?.toInt(),
        );
      }).toList();
      setState(() {
        pepito = transformed;
      });
      print(transformed);
      print('');
    } else {
      print('jsonData is null');
      // Handle the case when jsonData is null
    }
  }

  // void fetchcheckOut2() async {
  //   print('fetchordersssss');
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? jsonData = prefs.getInt('jsonData');

  //   if (jsonData != null) {
  //     final url =
  //         'http://gorder.website/API/check-out-get.php?id=$jsonData&payment_type=Gcash&delivery_type=Deliver';
  //     print(url);
  //     final uri = Uri.parse(url);
  //     final response = await http.get(uri);
  //     final body = response.body;
  //     final json = jsonDecode(body);
  //     print(json);
  //     final ord = json['order_details'] as List<dynamic>;

  //     final transformeds = ord.map((a) {
  //       return OrderDetails(
  //         subtotal: a["subtotal"],
  //         vat: a["vat"]?.toDouble(),
  //         discount: a["discount"],
  //         total: a["total"]?.toDouble(),
  //         deliveryFee: a["delivery_fee"],
  //       );
  //     }).toList();
  //     setState(() {
  //       orderDetailsList = transformeds;
  //     });
  //     print(transformeds);
  //     print('fetch sucess');
  //   } else {
  //     print('jsonData is null');
  //     // Handle the case when jsonData is null
  //   }
  // }
}
