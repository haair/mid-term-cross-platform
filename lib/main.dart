import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mid_term_1/screens/edit_product.dart';
import 'package:mid_term_1/services/database.dart';
import 'package:random_string/random_string.dart';
import 'firebase_options.dart';
import 'package:mid_term_1/models/product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const TabBarApp());
}

class TabBarApp extends StatelessWidget {
  const TabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const TabBarExample(),
    );
  }
}

class TabAddData extends StatelessWidget {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String? downloadURL;
  XFile? image;

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController nameControll = TextEditingController();
  final TextEditingController typeControll = TextEditingController();
  final TextEditingController priceControll = TextEditingController();
  final TextEditingController imgControll = TextEditingController();
  // final ImagePicker _picker = ImagePicker();

  TabAddData({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
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
            onTap: () {
              selectImage();
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
              await uploadImage();
              String id = randomAlphaNumeric(10);
              Map<String, dynamic> productInfoMap = {
                'id': id,
                'name': nameControll.text,
                'type': typeControll.text,
                'price': priceControll.text,
                'image': downloadURL,
              };
              await DatabaseMethods()
                  .addProduct(productInfoMap, id)
                  .then((value) {
                Fluttertoast.showToast(msg: 'ok');
                nameControll.clear();
                typeControll.clear();
                priceControll.clear();
                imgControll.clear();
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, foregroundColor: Colors.white),
            child: const Text("THÊM SẢN PHẨM"),
          ),
        ],
      ),
    );
  }

  Future selectImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    imgControll.text = image!.name;
  }

  Future<void> uploadImage() async {
    File file = File(image!.path);
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      await _storage.ref('images/$fileName').putFile(file);

      downloadURL = await _storage.ref('images/$fileName').getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}

class TabViewData extends StatelessWidget {
  final DatabaseMethods _firestoreService = DatabaseMethods();
  // final ImagePicker _picker = ImagePicker();

  TabViewData({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: StreamBuilder<List<Product>>(
        stream: _firestoreService.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final data = snapshot.data ?? [];
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(item.image),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                            // const TextSpan(
                            //     text: 'Tên SP: ',
                            //     style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: data[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ])),
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                            // const TextSpan(
                            //     text: 'Loại SP: ',
                            //     style: TextStyle(fontStyle: FontStyle.italic)),
                            TextSpan(
                                text: data[index].type,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic))
                          ])),
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                            const TextSpan(
                                text: '\$',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: data[index].price,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ])),
                    ],
                  ),
                  trailing: SizedBox(
                      width: 70,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditScreen(
                                            product: data[index],
                                          ))),
                              print(item.name)
                            },
                            child: const Icon(Icons.edit),
                          ),
                          InkWell(
                            onTap: () {
                              _showDeleteConfirmationDialog(
                                  context, item.id, _firestoreService);
                            },
                            child: const Icon(Icons.delete),
                          )
                        ],
                      )),
                );
              });
        },
      )),
    );
  }
}

void _showDeleteConfirmationDialog(
    BuildContext context, String id, DatabaseMethods firestoreService) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () async {
              await firestoreService.deleteProduct(id);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Test03'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.add_circle_outline),
              ),
              Tab(
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TabAddData(),
            TabViewData(),
          ],
        ),
      ),
    );
  }
}
