import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mid_term_1/models/product.dart';
import 'package:mid_term_1/services/database.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class EditScreen extends StatelessWidget {
  EditScreen({super.key, required this.product});

  Product product;
  final TextEditingController nameControll = TextEditingController();
  final TextEditingController typeControll = TextEditingController();
  final TextEditingController priceControll = TextEditingController();
  final TextEditingController imgControll = TextEditingController();

  String? downloadURL;

  @override
  Widget build(BuildContext context) {
    nameControll.text = product.name;
    typeControll.text = product.type;
    priceControll.text = product.price;
    imgControll.text = product.image;
    return Scaffold(
        appBar: AppBar(
          title: const Text("EDIT"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                // initialValue: product.name,
                controller: nameControll,
                decoration: const InputDecoration(
                    labelText: "Tên sản phẩm", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: typeControll,
                decoration: const InputDecoration(
                    labelText: "Loại sản phẩm", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: priceControll,
                decoration: const InputDecoration(
                    labelText: "Giá sản phẩm", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onTap: () async {
                  // selectImage();
                  await Clipboard.setData(
                      ClipboardData(text: imgControll.text));
                  Fluttertoast.showToast(msg: "URL was copy");
                },
                readOnly: true,
                controller: imgControll,
                decoration: const InputDecoration(
                    labelText: "Chọn ảnh",
                    prefixIcon: Icon(Icons.add_a_photo),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  // await uploadImage();
                  // String id = randomAlphaNumeric(10);
                  Map<String, dynamic> productInfoMap = {
                    'id': product.id,
                    'name': nameControll.text,
                    'type': typeControll.text,
                    'price': priceControll.text,
                    'image': imgControll.text,
                  };
                  await DatabaseMethods()
                      .update(productInfoMap, product.id)
                      .then((value) {
                    // nameControll.clear();
                    // typeControll.clear();
                    // priceControll.clear();
                    // imgControll.clear();
                  });
                  Fluttertoast.showToast(msg: "Update successfully");
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
                child: const Text("UPDATE"),
              ),
            ],
          ),
        ));
  }
}
